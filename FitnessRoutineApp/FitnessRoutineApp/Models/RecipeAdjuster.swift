import Foundation

/// Maneja ajustes avanzados de recetas según perfil de usuario
class RecipeAdjuster {
    // MARK: - Configurables
    private static let calorieAdjustment: Double = 500
    private static let fatRatio: Double = 0.25
    private static let proteinPerKg: Double = 1.2

    private let user: UserProfile
    private let dailyCaloriesTarget: Double

    init(profile: UserProfile = UserProfile.loadFromUserDefaults()) {
        self.user = profile
        self.dailyCaloriesTarget = RecipeAdjuster.calculateDailyCalories(for: profile)
    }

    // MARK: - API Pública

    func getDailyCaloriesTarget() -> Double {
        dailyCaloriesTarget
    }

    func calculateMacros() -> (protein: Double, fat: Double, carbs: Double) {
        let cals = dailyCaloriesTarget
        let proteinG = RecipeAdjuster.proteinPerKg * user.weightKg
        let fatCals = RecipeAdjuster.fatRatio * cals
        let fatG = fatCals / 9.0
        let remCals = cals - (proteinG * 4.0) - fatCals
        let carbG = max(remCals / 4.0, 0)
        return (RecipeAdjuster.rounded(proteinG), RecipeAdjuster.rounded(fatG), RecipeAdjuster.rounded(carbG))
    }

    func adjust(_ recipe: Recipe) -> Recipe {
        let overallFactor = dailyCaloriesTarget / Double(recipe.calories)

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

    // MARK: - Internals

    private static func calculateBMR(for user: UserProfile) -> Double {
        let weight = user.weightKg
        let height = Double(user.resolvedHeightCm)
        let currentYear = Calendar.current.component(.year, from: Date())
        let birthYear = Int(user.birthYear) ?? (currentYear - 30)
        let age = currentYear - birthYear

        guard age > 0 && age < 120 else {
            print("⚠️ Edad inválida detectada: \(age). Se usa valor por defecto 30.")
            return defaultBMR(for: user)
        }

        let genderNormalized = user.gender.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let isMale = ["male", "m", "hombre", "masculino"].contains(genderNormalized)

        if isMale {
            return 66.5 + (13.8 * weight) + (5.0 * height) - (6.8 * Double(age))
        }
        return 655.0 + (9.6 * weight) + (1.85 * height) - (4.7 * Double(age))
    }

    private static func defaultBMR(for user: UserProfile) -> Double {
        let weight = user.weightKg
        let height = Double(user.resolvedHeightCm)
        let isMale = ["male", "m", "hombre", "masculino"].contains(user.gender.lowercased())
        if isMale {
            return 66.5 + (13.8 * weight) + (5.0 * height) - (6.8 * 30)
        }
        return 655.0 + (9.6 * weight) + (1.85 * height) - (4.7 * 30)
    }

    private static func calculateDailyCalories(for user: UserProfile) -> Double {
        let bmr = calculateBMR(for: user)
        let activityFactors: [String: Double] = [
            "low": 1.2, "sedentary": 1.2,
            "medium": 1.375, "moderate": 1.55,
            "high": 1.725, "active": 1.725,
            "veryhigh": 1.9
        ]

        let key = user.levelActivity
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
            .replacingOccurrences(of: " ", with: "")

        guard let factor = activityFactors[key] else {
            print("⚠️ Nivel de actividad '\(user.levelActivity)' no reconocido. Usando 1.2 (baja).")
            return max(bmr * 1.2, 1200)
        }

        var calories = bmr * factor
        let diff = user.targetWeightKg - user.weightKg
        if diff > 0 { calories += calorieAdjustment }
        else if diff < 0 { calories -= calorieAdjustment }

        return max(calories, 1200)
    }

    // MARK: - Helpers

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
            print("⚠️ No se pudo parsear cantidad: \(s)")
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
            switch unit.lowercased() {
            case "g": return Measurement(value: roundedVal, unit: UnitMass.grams)
            case "kg": return Measurement(value: roundedVal, unit: UnitMass.kilograms)
            case "mg": return Measurement(value: roundedVal, unit: UnitMass.milligrams)
            case "ml": return Measurement(value: roundedVal, unit: UnitVolume.milliliters)
            case "l", "lt", "ltr": return Measurement(value: roundedVal, unit: UnitVolume.liters)
            case "tsp", "cucharadita":
                return Measurement(value: roundedVal, unit: UnitVolume.teaspoons)
            case "tbsp", "cucharada":
                return Measurement(value: roundedVal, unit: UnitVolume.tablespoons)
            case "cup", "taza":
                return Measurement(value: roundedVal, unit: UnitVolume.cups)
            case "oz", "onza":
                return Measurement(value: roundedVal, unit: UnitMass.ounces)
            default:
                if !unit.isEmpty {
                    print("⚠️ Unidad desconocida: '\(unit)'. Mostrando valor sin unidad formateada.")
                }
                return Measurement(value: roundedVal, unit: Unit(symbol: unit))
            }
        }()
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 1
        return formatter.string(from: measure)
    }

    private static func rounded(_ x: Double) -> Double {
        (x * 10).rounded() / 10
    }
}
