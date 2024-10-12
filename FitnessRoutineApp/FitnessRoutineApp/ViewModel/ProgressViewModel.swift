import SwiftUI

class ProgressViewModel: ObservableObject {
    @Published var progress: Double = 0.0

    func advanceProgress() {
        withAnimation {
            progress += 0.33 // Por ejemplo, avanzar un tercio del progreso
            if progress > 1.0 { progress = 1.0 }
        }
    }

    func decreaseProgress() {
        withAnimation {
            progress -= 0.33
            if progress < 0.0 { progress = 0.0 }
        }
    }
}
