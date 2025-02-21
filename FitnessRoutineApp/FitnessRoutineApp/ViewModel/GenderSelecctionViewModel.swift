import SwiftUI

// MARK: - Gender Enum
enum Gender: String {
    case male = "male"
    case female = "female"
}

// MARK: - GenderSelectionViewModel
class GenderSelectionViewModel: ObservableObject {
    @Published var selectedGender: Gender? {
        didSet {
            // Guardar automáticamente cada vez que se cambie el género
            saveGenderToUserDefaults()
        }
    }
    
    init() {
        // Cargar el género guardado al iniciar
        loadGenderFromUserDefaults()
    }
    
    func selectGender(_ gender: Gender) {
        selectedGender = gender
        print("Género seleccionado: \(gender.rawValue)")
    }

    // Guardar el género en UserDefaults
    private func saveGenderToUserDefaults() {
        if let gender = selectedGender {
            UserDefaults.standard.set(gender.rawValue, forKey: "gender")
        }
    }

    // Cargar el género desde UserDefaults
    private func loadGenderFromUserDefaults() {
        if let savedGender = UserDefaults.standard.string(forKey: "gender"),
           let gender = Gender(rawValue: savedGender) {
            selectedGender = gender
        }
    }
}
