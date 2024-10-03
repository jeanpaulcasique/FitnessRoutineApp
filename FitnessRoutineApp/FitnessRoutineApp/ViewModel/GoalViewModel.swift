import Foundation
import SwiftUI

class GoalViewModel: ObservableObject {
    @Published var selectedGoal: Goal?

    // Enum para los objetivos
    enum Goal {
        case loseWeight
        case buildMuscle
        case keepFit
    }

    // Función para seleccionar un objetivo
    func selectGoal(_ goal: Goal) {
        selectedGoal = goal
    }

    // Función para guardar el objetivo del usuario
    func saveUserGoal() {
        // Lógica para guardar el objetivo del usuario (por ejemplo, en Core Data o Firebase)
        if let selectedGoal = selectedGoal {
            print("Usuario guardó el objetivo: \(selectedGoal)")
            // Aquí podrías implementar la lógica para almacenar el objetivo
        }
    }
}
