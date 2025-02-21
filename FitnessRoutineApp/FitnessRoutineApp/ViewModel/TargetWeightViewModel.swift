import SwiftUI

// MARK: - TargetWeightViewModel
class TargetWeightViewModel: ObservableObject {
    @Published var selectedWeightKg: Double {
        didSet {
            // Guardar el peso seleccionado en UserDefaults
            UserDefaults.standard.set(selectedWeightKg, forKey: "targetWeightKg")
        }
    }
    @Published var isKgSelected: Bool = true
    @Published var healthBenefitMessage: String = ""

    init() {
        // Recuperar el peso seleccionado desde UserDefaults si existe
        if let savedWeight = UserDefaults.standard.value(forKey: "targetWeightKg") as? Double {
            self.selectedWeightKg = savedWeight
        } else {
            self.selectedWeightKg = 74.0 // Valor predeterminado
        }
    }

    var selectedWeightLb: Double {
        selectedWeightKg * 2.20462
    }

    var weightInPreferredUnit: Double {
        isKgSelected ? selectedWeightKg : selectedWeightLb
    }

    func toggleUnit(toKg: Bool) {
        isKgSelected = toKg
    }

    func updateHealthBenefitMessage() {
        let weightLossPercentage = ((85.0 - selectedWeightKg) / 85.0) * 100
        healthBenefitMessage = """
        Sweaty choice!
        You will lose \(String(format: "%.1f", weightLossPercentage))% of body weight
        You will gain continuous health benefits:
        - Lower blood lipids and blood pressure
        - Boost your metabolism
        """
    }

    func updateWeight(newWeight: Double) {
        selectedWeightKg = newWeight
        updateHealthBenefitMessage()
    }
}

