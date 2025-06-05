import SwiftUI
import Combine

// MARK: - DietTypeViewModel
class DietTypeViewModel: ObservableObject {
    @Published var currentIndex: Int {
        didSet {
            UserDefaults.standard.set(currentIndex, forKey: "dietTypeIndex")
            UserDefaults.standard.set(titles[currentIndex], forKey: "selectedDietType")
        }
    }

    // Using SF Symbols for demo; replace with asset names if available
    let imageNames = ["flame.fill", "leaf.fill", "scalemass.fill"]
    let titles = ["Keto", "Low‑Carb", "Calorie Deficit"]
    let longDescriptions = [
        "High fat, very low carbs, ideal for rapid fat burn.",
        "Balanced macros with reduced carbs for steady energy.",
        "Flexible eating, focus on a daily calorie goal."
    ]

    var imageCount: Int { imageNames.count }

    @Published var isLoading = false
    @Published var isNextButtonDisabled = false
    
    // Tracking de información mostrada
    private let infoShownKey = "dietInfoShown"

    init() {
        let saved = UserDefaults.standard.value(forKey: "dietTypeIndex") as? Int
        self.currentIndex = saved ?? 0
        UserDefaults.standard.set(titles[currentIndex], forKey: "selectedDietType")
    }

    func disableNextButtonTemporarily() {
        isNextButtonDisabled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isNextButtonDisabled = false
        }
    }
    
    // MARK: - Diet Info Management
    func hasShownInfoFor(index: Int) -> Bool {
        let shownIndices = UserDefaults.standard.array(forKey: infoShownKey) as? [Int] ?? []
        return shownIndices.contains(index)
    }
    
    func markInfoAsShown(for index: Int) {
        var shownIndices = UserDefaults.standard.array(forKey: infoShownKey) as? [Int] ?? []
        if !shownIndices.contains(index) {
            shownIndices.append(index)
            UserDefaults.standard.set(shownIndices, forKey: infoShownKey)
        }
    }
    
    func getDietInfo(for index: Int) -> DietInfo {
        switch index {
        case 0: // Keto
            return DietInfo(
                title: "Ketogenic Diet",
                description: "The ketogenic diet is a very low-carbohydrate, high-fat diet that puts your body into a metabolic state called ketosis, where it burns fat for fuel instead of carbohydrates.",
                howItWorks: "By drastically reducing carbohydrate intake (typically to under 20-50g per day) and increasing fat intake to 70-80% of total calories, your body depletes its glucose stores and begins producing ketones from fat breakdown. These ketones become the primary fuel source for your brain and muscles.",
                benefits: [
                    "Rapid initial weight loss due to water weight and fat burning",
                    "Reduced appetite and natural calorie restriction",
                    "Improved mental clarity and focus for many people",
                    "Better blood sugar control and insulin sensitivity",
                    "Increased energy levels once adapted (usually 2-4 weeks)"
                ],
                considerations: [
                    "Initial 'keto flu' symptoms including fatigue, headaches, and irritability",
                    "Requires strict carbohydrate monitoring and meal planning",
                    "May affect athletic performance initially until fat-adapted",
                    "Potential digestive issues and need for electrolyte management",
                    "Not suitable for everyone - consult healthcare provider first"
                ],
                color: .red,
                icon: "flame.fill"
            )
            
        case 1: // Low Carb
            return DietInfo(
                title: "Low-Carb Diet",
                description: "A low-carb diet reduces carbohydrate intake while maintaining moderate protein and fat levels. It's more flexible than keto but still promotes fat burning and weight loss.",
                howItWorks: "By limiting carbohydrates to 50-150g per day (depending on individual needs), your body relies more on fat for energy. This approach maintains some glucose availability while still promoting fat oxidation and reducing insulin spikes from high-carb meals.",
                benefits: [
                    "Sustainable long-term approach with more food flexibility",
                    "Steady weight loss without extreme restrictions",
                    "Better blood sugar control and reduced cravings",
                    "Maintains energy for workouts and daily activities",
                    "Easier to follow in social situations and dining out"
                ],
                considerations: [
                    "Weight loss may be slower compared to very low-carb approaches",
                    "Still requires monitoring carbohydrate sources and portions",
                    "Individual carb tolerance varies - may need adjustment",
                    "Focus on quality carbs (vegetables, fruits) over processed foods",
                    "May take time to find the right carb level for your goals"
                ],
                color: .green,
                icon: "leaf.fill"
            )
            
        case 2: // Calorie Deficit
            return DietInfo(
                title: "Calorie Deficit Diet",
                description: "A calorie deficit approach focuses on consuming fewer calories than you burn, regardless of macronutrient composition. This is the fundamental principle behind all weight loss.",
                howItWorks: "By creating a consistent caloric deficit of 300-500 calories per day through diet, exercise, or both, your body is forced to use stored energy (fat and some muscle) to meet its daily needs. A pound of fat equals approximately 3,500 calories.",
                benefits: [
                    "Complete dietary flexibility - no foods are off-limits",
                    "Scientifically proven method for weight loss",
                    "Can accommodate any lifestyle or dietary preference",
                    "Teaches portion control and calorie awareness",
                    "Sustainable approach that builds long-term habits"
                ],
                considerations: [
                    "Requires tracking calories and portions accurately",
                    "May need to learn about calorie content of foods",
                    "Hunger management can be challenging initially",
                    "Progress may be slower but more sustainable",
                    "Important to maintain adequate nutrition within calorie limits"
                ],
                color: .blue,
                icon: "scalemass.fill"
            )
            
        default:
            return getDietInfo(for: 0) // Fallback to Keto
        }
    }
}
