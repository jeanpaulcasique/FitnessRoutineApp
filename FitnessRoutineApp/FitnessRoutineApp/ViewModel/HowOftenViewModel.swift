import SwiftUI
import Combine

// MARK: - HowOftenViewModel
class HowOftenViewModel: ObservableObject {
    @Published var currentIndex: Int {
        didSet {
            // Guardar el índice de la opción seleccionada en UserDefaults
            UserDefaults.standard.set(currentIndex, forKey: "workoutFrequencyIndex")
        }
    }
    
    let imageNames = ["1time", "2time", "3time", "4time"]
    let descriptions = [
        "I'm so busy, and would like to work out once in a while",
        "I would like to work out a few times a week",
        "I’m motivated to exercise almost every day",
        "I'm committed to daily workouts for optimal results"
    ]
    
    var imageCount: Int { imageNames.count }
    
    var currentImageName: String { imageNames[currentIndex] }
    
    var descriptionText: String { descriptions[currentIndex] }
    
    init() {
        // Recuperar el índice de la opción seleccionada desde UserDefaults
        if let savedIndex = UserDefaults.standard.value(forKey: "workoutFrequencyIndex") as? Int {
            self.currentIndex = savedIndex
        } else {
            self.currentIndex = 0 // Valor predeterminado si no existe en UserDefaults
        }
    }
    
    func nextImage() {
        if currentIndex < imageNames.count - 1 {
            currentIndex += 1
        }
    }
    
    func previousImage() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }
}

