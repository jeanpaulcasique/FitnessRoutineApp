import SwiftUI

class TargetWeightViewModel: ObservableObject {
    @Published var selectedWeightKg: Double = 74.0 // Peso inicial
    @Published var isKgSelected: Bool = true // Para manejar la selección entre kg y lb
    @Published var healthBenefitMessage: String = ""
    
    var selectedWeightLb: Double {
        return selectedWeightKg * 2.20462
    }
    
    var weightInPreferredUnit: Double {
        return isKgSelected ? selectedWeightKg : selectedWeightLb
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
