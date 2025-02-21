import SwiftUI
import Combine

enum Goal: String, CaseIterable {
    case loseWeight = "Lose Weight"
    case buildMuscle = "Build Muscle"
    case keepFit = "Keep Fit"
}

class GoalViewModel: ObservableObject {
    @Published var selectedGoal: Goal? {
        didSet {
            if let goal = selectedGoal {
                UserDefaults.standard.set(goal.rawValue, forKey: "selectedGoal") // Guardar en UserDefaults
            }
        }
    }

    init() {
        loadGoalFromUserDefaults() // Cargar valor guardado al iniciar
    }

    func selectGoal(_ goal: Goal) {
        selectedGoal = goal
    }

    func loadGoalFromUserDefaults() {
        if let savedGoal = UserDefaults.standard.string(forKey: "selectedGoal"),
           let goal = Goal(rawValue: savedGoal) {
            selectedGoal = goal
        }
    }
}

