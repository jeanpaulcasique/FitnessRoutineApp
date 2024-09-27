import SwiftUI

// Enum para los géneros debe ser accesible globalmente
enum Gender {
    case male
    case female
}

class GenderSelectionViewModel: ObservableObject {
    @Published var selectedGender: Gender? = nil
    
    // Función para seleccionar el género
    func selectGender(_ gender: Gender) {
        selectedGender = gender
        // Al seleccionar el género, se actualiza el estado del usuario en el UserSessionManager
        UserSessionManager.shared.updateGender(gender: gender)
    }
    
    // Función para continuar a la siguiente pantalla
    func continueToNextScreen() {
        // Lógica para navegar a la siguiente pantalla
        print("Navegando a la siguiente pantalla...")
        // Puedes incluir lógica adicional aquí si es necesario
    }
}

