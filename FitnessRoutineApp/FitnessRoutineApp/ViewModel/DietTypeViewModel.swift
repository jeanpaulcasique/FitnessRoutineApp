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
    
}
