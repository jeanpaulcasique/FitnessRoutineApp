import SwiftUI
import Combine

// MARK: - HowOftenViewModel
class HowOftenViewModel: ObservableObject {
    @Published var currentIndex: Int {
        didSet {
            // Guardar el índice de la opción seleccionada en UserDefaults
            UserDefaults.standard.set(currentIndex, forKey: "workoutFrequencyIndex")
            
            // Guardar también el texto correspondiente
            UserDefaults.standard.set(descriptions[currentIndex], forKey: "selectedHowOften")
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

    // Lógica para el botón "Next"
    @Published var isLoading: Bool = false
    @Published var isNextButtonDisabled: Bool = false

    init() {
        // Recuperar el índice de la opción seleccionada desde UserDefaults
        if let savedIndex = UserDefaults.standard.value(forKey: "workoutFrequencyIndex") as? Int {
            self.currentIndex = savedIndex
        } else {
            self.currentIndex = 0 // Valor predeterminado si no existe en UserDefaults
        }

        // Asegurar que el texto también se guarda al iniciar
        UserDefaults.standard.set(descriptions[currentIndex], forKey: "selectedHowOften")
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
    
    // Función para habilitar el botón "Next"
    func disableNextButtonTemporarily() {
        isNextButtonDisabled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isNextButtonDisabled = false
        }
    }
}

