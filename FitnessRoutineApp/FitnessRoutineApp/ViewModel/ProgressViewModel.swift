import SwiftUI

class ProgressViewModel: ObservableObject {
    @Published var currentProgress: Int = 0
    let totalSteps: Int = 3 // Total de pantallas (GenderSelection, Goal, BodyCurrent)

    func advanceProgress() {
        if currentProgress < totalSteps {
            currentProgress += 1
        }
    }

    func decreaseProgress() {
        if currentProgress > 0 {
            currentProgress -= 1
        }
    }

    func resetProgress() {
        currentProgress = 0
    }
}


