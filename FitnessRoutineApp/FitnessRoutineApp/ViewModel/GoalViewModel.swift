import SwiftUI

class GoalViewModel: ObservableObject {
    @Published var selectedGoal: Goal?

    enum Goal {
        case loseWeight
        case buildMuscle
        case keepFit
    }

    // Función para seleccionar la meta
    func selectGoal(_ goal: Goal) {
        selectedGoal = goal
    }

    // Función para guardar la meta seleccionada
    func saveUserGoal() {
        // Aquí va la lógica para guardar la meta del usuario
        print("User goal saved: \(selectedGoal ?? .loseWeight)")
    }
}
