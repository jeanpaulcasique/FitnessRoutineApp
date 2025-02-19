import SwiftUI

class ProgressViewModel: ObservableObject {
    @Published var progress: Double = 0.0
    private var totalScreens: Int = 11 // Número total de pantallas

    init(totalScreens: Int = 11) {
        self.totalScreens = totalScreens
    }

    func advanceProgress() {
        withAnimation {
            progress += 1.0 / Double(totalScreens) // Incrementa proporcionalmente
            if progress > 1.0 {
                progress = 1.0 // Evita superar el máximo
            }
        }
    }

    func decreaseProgress() {
        withAnimation {
            progress -= 1.0 / Double(totalScreens) // Decrementa proporcionalmente
            if progress < 0.0 {
                progress = 0.0 // Evita caer por debajo del mínimo
            }
        }
    }

    func resetProgress() {
        withAnimation {
            progress = 0.0
        }
    }
}

