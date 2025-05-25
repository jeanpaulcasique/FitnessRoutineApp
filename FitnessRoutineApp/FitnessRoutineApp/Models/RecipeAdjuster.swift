import Foundation

/// Maneja ajustes avanzados de recetas según perfil de usuario
class RecipeAdjuster {
    // MARK: - Configurables
    /// Kcal a sumar/restar para ganancia/pérdida de peso
    private static let calorieAdjustment: Double = 500
    /// Porcentaje de calorías de grasas
    private static let fatRatio: Double = 0.25
    /// Proteína base en g/kg
    private static let proteinPerKg: Double = 1.2

    private let user: UserProfile
    private let dailyCaloriesTarget: Double

    init(profile: UserProfile = UserProfile.loadFromUserDefaults()) {
        self.user = profile
        self.dailyCaloriesTarget = RecipeAdjuster.calculateDailyCalories(for: profile)
    }

    // MARK: - API Pública

    /// Obtiene calorías diarias objetivo
    func getDailyCaloriesTarget() -> Double {
        dailyCaloriesTarget
    }

    /// Calcula distribución de macronutrientes: proteína, grasa, carbohidratos (en gramos)
    func calculateMacros() -> (protein: Double, fat: Double, carbs: Double) {
        let cals = dailyCaloriesTarget
        let proteinG = RecipeAdjuster.proteinPerKg * user.weightKg
        let fatCals = RecipeAdjuster.fatRatio * cals
        let fatG = fatCals / 9.0
        let remCals = cals - (proteinG * 4.0) - fatCals
        let carbG = max(remCals / 4.0, 0)
        return (RecipeAdjuster.rounded(proteinG), RecipeAdjuster.rounded(fatG), RecipeAdjuster.rounded(carbG))
    }

    /// Ajusta una receta a las necesidades del usuario
    func adjust(_ recipe: Recipe) -> Recipe {
        let baseFactor = dailyCaloriesTarget / Double(recipe.calories)
        let overallFactor = baseFactor * user.adjustmentFactor()

        let adjustedIngredients = recipe.ingredients.map { ing in
            let (baseQty, unit) = RecipeAdjuster.parseQuantity(ing.quantity)
            let newQty = baseQty * overallFactor
            let qtyString = RecipeAdjuster.formatQuantity(newQty, unit: unit)
            return Ingredient(name: ing.name, quantity: qtyString, isChecked: ing.isChecked)
        }

        let adjustedCalories = Int((Double(recipe.calories) * overallFactor).rounded())
        return Recipe(
            title: recipe.title,
            mealType: recipe.mealType,
            imageName: recipe.imageName,
            ingredients: adjustedIngredients,
            instructions: recipe.instructions,
            calories: adjustedCalories
        )
    }

    // MARK: - Internals: Cálculos

    private static func calculateBMR(for user: UserProfile) -> Double {
        let weight = user.weightKg
        let height = Double(user.resolvedHeightCm)
        let currentYear = Calendar.current.component(.year, from: Date())
        let birthYear = Int(user.birthYear) ?? (currentYear - 30)
        let age = currentYear - birthYear

        if user.gender.lowercased().contains("male") {
            return 66.5 + (13.8 * weight) + (5.0 * height) - (6.8 * Double(age))
        }
        return 655.0 + (9.6 * weight) + (1.85 * height) - (4.7 * Double(age))
    }

    private static func calculateDailyCalories(for user: UserProfile) -> Double {
        let bmr = calculateBMR(for: user)
        let activityFactors: [String: Double] = [
            "low": 1.2, "sedentary": 1.2,
            "medium": 1.375, "moderate": 1.55,
            "high": 1.725, "active": 1.725,
            "veryhigh": 1.9
        ]
        let key = user.levelActivity.lowercased().replacingOccurrences(of: " ", with: "")
        let factor = activityFactors[key] ?? 1.2
        var calories = bmr * factor

        // Ajuste objetivo: ±calorieAdjustment
        let diff = user.targetWeightKg - user.weightKg
        if diff > 0 { calories += calorieAdjustment }
        else if diff < 0 { calories -= calorieAdjustment }

        return max(calories, 1200)
    }

    // MARK: - Helpers de parseo y formateo

    private static func parseQuantity(_ s: String) -> (Double, String) {
        let fractionPattern = #"(\d+)\/(\d+)"#
        var string = s
        if let fracMatch = try? NSRegularExpression(pattern: fractionPattern).firstMatch(in: s, range: NSRange(s.startIndex..., in: s)),
           let numR = Range(fracMatch.range(at: 1), in: s), let denR = Range(fracMatch.range(at: 2), in: s) {
            let num = Double(s[numR]) ?? 0, den = Double(s[denR]) ?? 1
            let decimal = num / den
            string = s.replacingOccurrences(of: "\(s[numR])/\(s[denR])", with: "\(decimal)")
        }
        let pattern = #"([0-9]*\.?[0-9]+)\s*([a-zA-Z%]+)?"#
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(in: string, range: NSRange(string.startIndex..., in: string)),
              let r1 = Range(match.range(at: 1), in: string) else {
            return (0, s)
        }
        let number = Double(string[r1]) ?? 0
        var unit = ""
        if let r2 = Range(match.range(at: 2), in: string) {
            unit = String(string[r2])
        }
        return (number, unit)
    }

    private static func formatQuantity(_ value: Double, unit: String) -> String {
        let roundedVal = rounded(value)
        let measure: Measurement<Unit> = {
            // Asumimos unidad métrica simple. Para unidades complejas, ajustar aquí
            switch unit.lowercased() {
            case "g": return Measurement(value: roundedVal, unit: UnitMass.grams)
            case "ml": return Measurement(value: roundedVal, unit: UnitVolume.milliliters)
            default: return Measurement(value: roundedVal, unit: Unit(symbol: unit))
            }
        }()
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        return formatter.string(from: measure)
    }

    private static func rounded(_ x: Double) -> Double {
        (x * 10).rounded() / 10
    }
}

