import SwiftUI
import Combine
import Foundation

// MARK: - DietViewModel

class DietViewModel: ObservableObject {
    @Published var selectedDiet: String {
        didSet {
            let normalized = selectedDiet.lowercased().filter { $0.isLetter }
            UserDefaults.standard.set(selectedDiet, forKey: Self.selectedDietKey)
            loadRecipesForSelectedDiet(normalizedDiet: normalized)
        }
    }
    @Published var days: [Date] = []
    @Published var selectedDay: Date = Date()
    @Published var weeklyRecipes: [Date: [Recipe]] = [:]
    @Published var groceryList: [Ingredient] = []

    private let calendar = Calendar(identifier: .gregorian)
    private static let selectedDietKey = "selectedDietType"
    private static let checkedKey = "checkedIngredients"

    private var userProfile: UserProfile = UserProfile.loadFromUserDefaults()
    private var adjuster: RecipeAdjuster!

    // MARK: - Init

    init() {
        let stored = UserDefaults.standard.string(forKey: Self.selectedDietKey) ?? "Keto"
        selectedDiet = stored

        setupDays()
        updateAdjuster()
        let normalized = stored.lowercased().filter { $0.isLetter }
        loadRecipesForSelectedDiet(normalizedDiet: normalized)
        updateGroceryList()
    }

    // MARK: - Public Methods

    func select(day: Date) {
        selectedDay = day
    }

    func updateUserProfile(_ newProfile: UserProfile) {
        userProfile = newProfile
        UserDefaults.standard.set(newProfile.dietType, forKey: Self.selectedDietKey)
        updateAdjuster()
        let normalized = selectedDiet.lowercased().filter { $0.isLetter }
        loadRecipesForSelectedDiet(normalizedDiet: normalized)
        updateGroceryList()
    }

    func recipes(for meal: MealType) -> [Recipe] {
        weeklyRecipes[selectedDay]?.filter { $0.mealType == meal } ?? []
    }

    func dayNumber(from date: Date) -> String {
        let components = calendar.dateComponents([.day], from: date)
        return "\(components.day ?? 0)"
    }

    // MARK: - Método agregado para obtener calorías objetivo diarias
    func getDailyCaloriesTarget() -> Double {
        // Aquí puedes calcular las calorías objetivo basándote en el perfil del usuario
        // Por ahora retorno un valor base que puedes ajustar según tu lógica
        let baseCalories: Double
        
        switch selectedDiet.lowercased() {
        case "keto":
            baseCalories = 1800
        case "lowcarb":
            baseCalories = 2000
        case "caloriedeficit", "deficit":
            baseCalories = 1500
        default:
            baseCalories = 2000
        }
        
        // Ajustar según el perfil del usuario si es necesario
        // Ejemplo: ajustar por peso, altura, edad, etc.
        var adjustedCalories = baseCalories
        
        if userProfile.weightKg > 80 {
            adjustedCalories += 200
        } else if userProfile.weightKg < 60 {
            adjustedCalories -= 200
        }
        
        return adjustedCalories
    }

    func calculateRecommendedWaterIntake() -> String {
        let weight = userProfile.weightKg
        let age: Int = {
            let currentYear = Calendar.current.component(.year, from: Date())
            return currentYear - (Int(userProfile.birthYear) ?? (currentYear - 30))
        }()
        let gender = userProfile.gender.lowercased()
        let height = Double(userProfile.resolvedHeightCm)

        guard weight > 0 else { return "Set your weight to get recommendation" }
        var liters = weight * 0.033
        if height > 180 { liters *= 1.05 }
        else if height < 160 { liters *= 0.95 }
        if age < 14 { liters *= 0.8 }
        if gender.contains("male") { liters *= 1.1 }
        return String(format: "%.1f L", liters)
    }

    func toggleCheck(for ing: Ingredient) {
        if let idx = groceryList.firstIndex(where: { $0.id == ing.id }) {
            groceryList[idx].isChecked.toggle()
            saveCheckedIngredientNames()
        }
    }

    func saveCheckedIngredientNames() {
        let names = groceryList.filter { $0.isChecked }.map { $0.name }
        UserDefaults.standard.set(names, forKey: Self.checkedKey)
    }

    var groceryListText: String {
        let header = "🛒 Grocery List (\(selectedDiet))\n\n"
        let items = groceryList.map { "- \($0.name): \($0.quantity)" }.joined(separator: "\n")
        return header + items
    }

    // MARK: - Water Notifications

    func startWaterRemindersThreeTimes() {
        let rec = calculateRecommendedWaterIntake()
        NotificationWater.shared.requestAuthorization { granted in
            guard granted else { return }
            let breakfast = DateComponents(hour: 9, minute: 0)
            let lunch     = DateComponents(hour: 13, minute: 0)
            let dinner    = DateComponents(hour: 19, minute: 0)
            NotificationWater.shared.scheduleThreeDailyReminders(
                at: [breakfast, lunch, dinner],
                dailyRecommendation: rec
            )
        }
    }

    func stopWaterRemindersThreeTimes() {
        NotificationWater.shared.cancelThreeDailyReminders()
    }

    // MARK: - Private Helpers

    private func setupDays() {
        let today = calendar.startOfDay(for: Date())
        let weekday = calendar.component(.weekday, from: today)
        // Ajustar el inicio de semana para que sea lunes (1) a domingo (7)
        let offset = (weekday == 1 ? -6 : 2 - weekday)
        guard let start = calendar.date(byAdding: .day, value: offset, to: today) else { return }
        days = (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: start) }
        selectedDay = days.first ?? today
    }

    private func updateAdjuster() {
        adjuster = RecipeAdjuster(profile: userProfile)
    }

    private func loadRecipesForSelectedDiet(normalizedDiet: String) {
        let source: [[Recipe]]
        switch normalizedDiet {
        case "keto":
            source = RecipesKeto.getRecipesOrganizedByDay()
        case "lowcarb":
            source = RecipesLowCarb.getRecipesOrganizedByDay()
        case "caloriedeficit", "deficit":
            source = organizeRecipesByDay(RecipesDeficit.getWeeklyRecipes())
        default:
            source = RecipesKeto.getRecipesOrganizedByDay()
        }

        weeklyRecipes.removeAll()
        for (i, day) in days.enumerated() where i < source.count {
            let adjusted = source[i].map { adjuster.adjust($0) }
            weeklyRecipes[day] = adjusted
        }
        updateGroceryList()
    }
    
    func organizeRecipesByDay(_ recipes: [Recipe]) -> [[Recipe]] {
        var days: [[Recipe]] = []
        let recipesPerDay = 3 // desayuno, almuerzo, cena

        var currentDayRecipes: [Recipe] = []
        for (index, recipe) in recipes.enumerated() {
            currentDayRecipes.append(recipe)
            if (index + 1) % recipesPerDay == 0 {
                days.append(currentDayRecipes)
                currentDayRecipes = []
            }
        }

        if !currentDayRecipes.isEmpty {
            days.append(currentDayRecipes)
        }
        return days
    }
    
    private func updateGroceryList() {
        let allIngredients = weeklyRecipes.values.flatMap { $0 }.flatMap { $0.ingredients }
        let checked = loadCheckedIngredientNames()
        let grouped = Dictionary(grouping: allIngredients, by: { $0.name }).map { name, items -> Ingredient in
            let qty = combineQuantities(items.map { $0.quantity })
            let isChecked = checked.contains(name)
            return Ingredient(name: name, quantity: qty, isChecked: isChecked)
        }
        groceryList = grouped.sorted { $0.name < $1.name }
    }

    private func loadCheckedIngredientNames() -> [String] {
        UserDefaults.standard.stringArray(forKey: Self.checkedKey) ?? []
    }

    private func combineQuantities(_ quantities: [String]) -> String {
        var total: Double = 0
        var unit: String?
        let pattern = #"([0-9]*\.?[0-9]+)(.*)"#
        let regex = try? NSRegularExpression(pattern: pattern)

        for q in quantities {
            guard let m = regex?.firstMatch(in: q, range: NSRange(q.startIndex..., in: q)),
                  let nr = Range(m.range(at: 1), in: q),
                  let ur = Range(m.range(at: 2), in: q) else {
                return quantities.joined(separator: " + ")
            }
            let num = Double(q[nr]) ?? 0
            let u = q[ur].trimmingCharacters(in: .whitespaces)
            if unit == nil {
                unit = u
            } else if unit != u {
                return quantities.joined(separator: " + ")
            }
            total += num
        }

        guard let u = unit else {
            return quantities.joined(separator: " + ")
        }

        return total.truncatingRemainder(dividingBy: 1) == 0 ?
            "\(Int(total))\(u)" :
            String(format: "%.1f%@", total, u)
    }
}

// MARK: - Models (para referencia)

struct Recipe: Identifiable {
    let id = UUID()
    let title: String
    let mealType: MealType
    let imageName: String
    let ingredients: [Ingredient]
    let instructions: String
    let calories: Int
}

struct Ingredient: Identifiable, Equatable {
    let id = UUID()
    let name: String
    var quantity: String
    var isChecked: Bool = false

    static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        lhs.id == rhs.id && lhs.isChecked == rhs.isChecked
    }
}

enum MealType: String, CaseIterable, Identifiable {
    case Breakfast, Lunch, Dinner
    var id: String { rawValue }
    var displayName: String {
        switch self {
        case .Breakfast: return "🍳 Breakfast"
        case .Lunch:     return "🥗 Lunch"
        case .Dinner:    return "🍽 Dinner"
        }
    }
}
