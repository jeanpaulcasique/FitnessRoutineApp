import Foundation

struct UserProfile {
    let gender: String
    let heightCm: Int?
    let heightFt: Int?
    let heightInch: Int?
    let weightKg: Double
    let targetWeightKg: Double
    let goal: String
    let equipmentPreference: String
    let bodyCurrentImage: String
    let desiredBodyImage: String
    let birthYear: String
    let target: String
    let workoutLevel: String
    let levelActivity: String
    let dietType: String

    init() {
        let defaults = UserDefaults.standard
        gender = defaults.string(forKey: "gender") ?? "Not Set"
        heightCm = defaults.value(forKey: "selectedHeightCm") as? Int
        heightFt = defaults.value(forKey: "selectedHeightFt") as? Int
        heightInch = defaults.value(forKey: "selectedHeightInch") as? Int
        weightKg = defaults.double(forKey: "selectedWeightKg")
        targetWeightKg = defaults.double(forKey: "selectedTargetWeight")
        goal = defaults.string(forKey: "selectedGoal") ?? "Not Set"
        equipmentPreference = defaults.string(forKey: "equipmentPreference") ?? "Not Set"
        bodyCurrentImage = defaults.string(forKey: "bodyCurrentImage") ?? "Not Set"
        desiredBodyImage = defaults.string(forKey: "desiredBodyImage") ?? "Not Set"
        birthYear = defaults.string(forKey: "selectedBirthYear") ?? "Not Set"
        target = defaults.string(forKey: "selectedTarget") ?? "Not Set"
        workoutLevel = defaults.string(forKey: "selectedWorkoutLevel") ?? "Not Set"
        levelActivity = defaults.string(forKey: "selectedLevelActivity") ?? "Not Set"
        dietType = defaults.string(forKey: "selectedDietType") ?? "Not Set"
    }

    var totalHeightInCm: Int? {
        if let cm = heightCm, cm > 0 {
            return cm
        }
        if let ft = heightFt, let inch = heightInch {
            return Int(Double(ft) * 30.48 + Double(inch) * 2.54)
        }
        return nil
    }
    
    var resolvedHeightCm: Int {
        totalHeightInCm ?? 170
    }

    func adjustmentFactor() -> Double {
        var factor = 1.0

        switch gender.lowercased() {
        case "male":
            factor *= 1.1
        case "female":
            factor *= 1.0
        default:
            factor *= 1.0
        }

        if let year = Int(birthYear), year > 1900 {
            let age = Calendar.current.component(.year, from: Date()) - year
            switch age {
            case 18..<30:
                factor *= 1.05
            case 30..<45:
                factor *= 1.0
            case 45..<60:
                factor *= 0.95
            case 60...:
                factor *= 0.9
            default:
                break
            }
        }

        if weightKg > 0 {
            factor *= weightKg / 70.0
        }

        factor *= Double(resolvedHeightCm) / 170.0

        switch levelActivity.lowercased() {
        case "low", "sedentary":
            factor *= 0.9
        case "medium", "moderate":
            factor *= 1.0
        case "high", "active":
            factor *= 1.2
        default:
            break
        }

        return factor
    }

    static func loadFromUserDefaults() -> UserProfile {
        UserProfile()
    }
}
