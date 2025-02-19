import SwiftUI

// MARK: - Goal Enum
enum Goal: String, CaseIterable {
    case loseWeight = "Lose Weight"
    case buildMuscle = "Build Muscle"
    case keepFit = "Keep Fit"
}

// MARK: - GoalViewModel
class GoalViewModel: ObservableObject {
    @Published var selectedGoal: Goal?

    func selectGoal(_ goal: Goal) {
        selectedGoal = goal
        print("Objetivo seleccionado: \(goal.rawValue)")
    }
}

