import SwiftUI
import Combine

class ProgressViewModel: ObservableObject {
    @Published var currentProgress: Int = 0
    let totalSteps: Int = 3 // Número total de pasos que deseas manejar

    func advanceProgress() {
        if currentProgress < totalSteps { // Cambia 3 a tu máximo deseado
            currentProgress += 1
        }
    }

    func decreaseProgress() {
        if currentProgress > 0 { // Asegúrate de no bajar de 0
            currentProgress -= 1
        }
    }
}

