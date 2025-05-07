import SwiftUI

class DashboardViewModel: ObservableObject {
    // Aquí puedes añadir las propiedades o lógica necesaria para gestionar el estado del Dashboard

    // Ejemplo de propiedades
    @Published var selectedTab: Int = 0 // Mantener el índice de la pestaña seleccionada
    @Published var userProfile: UserProfile? // Puedes utilizar este ejemplo para gestionar el perfil del usuario

    // Si deseas añadir más lógica o realizar acciones específicas al cambiar de pestaña
    func updateTabSelection(to index: Int) {
        selectedTab = index
    }
    
    // Aquí puedes gestionar la información del usuario
    func fetchUserProfile() {
        // Lógica para obtener el perfil del usuario
    }
}

// Ejemplo de un modelo de perfil de usuario
struct UserProfile {
    var name: String
    var email: String
    var age: Int
}

