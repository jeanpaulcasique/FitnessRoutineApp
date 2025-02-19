import SwiftUI

// MARK: - HeightViewModel
class HeightViewModel: ObservableObject {
    @Published var selectedHeightCm: Int = 175
    @Published var selectedHeightFt: Int = 5
    @Published var selectedHeightInch: Int = 9
    @Published var isCmSelected: Bool = true

    // MARK: - Unit Toggle
    func toggleUnit(toCm: Bool) {
        isCmSelected = toCm
    }

    // MARK: - Update Height (cm)
    func updateHeightInCm(_ value: Double) {
        if value >= 100 && value <= 230 {
            selectedHeightCm = Int(value)
        }
    }

    // MARK: - Increment / Decrement for Feet & Inches
    func incrementFeetAndInches() {
        if selectedHeightInch < 11 {
            selectedHeightInch += 1
        } else if selectedHeightFt < 8 {
            selectedHeightInch = 0
            selectedHeightFt += 1
        }
    }

    func decrementFeetAndInches() {
        if selectedHeightInch > 0 {
            selectedHeightInch -= 1
        } else if selectedHeightFt > 3 {
            selectedHeightInch = 11
            selectedHeightFt -= 1
        }
    }

    // MARK: - Height Conversion Helper
    func heightInCm() -> Int {
        let totalInches = (selectedHeightFt * 12) + selectedHeightInch
        let cmHeight = Double(totalInches) * 2.54
        return Int(cmHeight)
    }
}

