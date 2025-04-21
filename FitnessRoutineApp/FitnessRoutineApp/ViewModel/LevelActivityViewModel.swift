import SwiftUI
import Combine

// MARK: - LevelActivityViewModel
class LevelActivityViewModel: ObservableObject {
    @Published var sliderValue: Double {
        didSet {
            updateActivityLevel()
            // Guardar valor y texto en UserDefaults
            UserDefaults.standard.set(sliderValue, forKey: "activityLevelSliderValue")
            UserDefaults.standard.set(selectedLevel, forKey: "selectedLevelActivity")
            UserDefaults.standard.set(activityDescription, forKey: "selectedLevelActivityDescription")
        }
    }

    @Published var currentImageName: String = "1level"
    @Published var activityDescription: String = "I sit at my desk all day"
    @Published var isLoading: Bool = false
    @Published var isNextButtonDisabled: Bool = false

    var selectedLevel: String = "Sedentary"

    private let imageNames = ["1level", "2level", "3level", "4level"]
    private let descriptions = [
        "I sit at my desk all day",
        "I occasionally exercise or walk for 30 minutes",
        "I love working out, and want to get more exercises",
        "I am very active and work out daily"
    ]
    private let levelLabels = ["Sedentary", "Lightly Active", "Active", "Very Active"]

    init() {
        // Recuperar el valor del slider
        if let savedValue = UserDefaults.standard.value(forKey: "activityLevelSliderValue") as? Double {
            self.sliderValue = savedValue
        } else {
            self.sliderValue = 0
        }
        updateActivityLevel()
    }

    func updateActivityLevel() {
        let index = Int(sliderValue)
        currentImageName = imageNames[index]
        activityDescription = descriptions[index]
        selectedLevel = levelLabels[index]
    }

    /// Deshabilita el botón Next durante 2 segundos
    func disableNextButtonTemporarily() {
        isNextButtonDisabled = true
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isNextButtonDisabled = false
            self.isLoading = false
        }
    }
}

