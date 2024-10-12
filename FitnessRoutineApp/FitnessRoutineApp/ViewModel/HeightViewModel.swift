import SwiftUI

class HeightViewModel: ObservableObject {
    @Published var selectedHeightCm: Int = 175
    @Published var selectedHeightFt: Int = 5
    @Published var selectedHeightInch: Int = 9
    @Published var isCmSelected: Bool = true

    // Función para alternar entre centímetros y pies
    func toggleUnit(toCm: Bool) {
        isCmSelected = toCm
    }

    // Función para cambiar el valor del selector en cm
    func updateHeightInCm(_ value: Double) {
        if value >= 100 && value <= 230 { // Limitar el rango de altura en cm
            selectedHeightCm = Int(value)
        }
    }

    // Función para incrementar pies y pulgadas
    func incrementFeetAndInches() {
        if selectedHeightInch < 11 {
            selectedHeightInch += 1
        } else if selectedHeightFt < 8 {
            selectedHeightInch = 0
            selectedHeightFt += 1
        }
    }

    // Función para decrementar pies y pulgadas
    func decrementFeetAndInches() {
        if selectedHeightInch > 0 {
            selectedHeightInch -= 1
        } else if selectedHeightFt > 3 {
            selectedHeightInch = 11
            selectedHeightFt -= 1
        }
    }

    // Convierte la altura de pies/pulgadas a centímetros
    func heightInCm() -> Int {
        let totalInches = (selectedHeightFt * 12) + selectedHeightInch
        let cmHeight = Double(totalInches) * 2.54
        return Int(cmHeight)
    }
}

