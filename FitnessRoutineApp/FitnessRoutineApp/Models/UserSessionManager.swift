import Foundation
import Combine

class UserSessionManager: ObservableObject {
    static let shared = UserSessionManager()
    
    @Published var currentUser: User = User()
    
    private init() {}
    
    // Función para actualizar el género
    func updateGender(gender: Gender) {
        currentUser.gender = gender
    }
    
    // Función para actualizar el objetivo
    func updateGoal(goal: String) {
        currentUser.goal = goal
    }
    
    // Función para guardar en Core Data y Firebase
    func saveUserData() {
        // Guardar en Core Data
        saveToCoreData(user: currentUser)
        
        // Guardar en Firebase
        saveToFirebase(user: currentUser)
    }
    
    private func saveToCoreData(user: User) {
        // Implementar la lógica de Core Data aquí
    }
    
    private func saveToFirebase(user: User) {
        // Implementar la lógica de Firebase aquí
    }
}

