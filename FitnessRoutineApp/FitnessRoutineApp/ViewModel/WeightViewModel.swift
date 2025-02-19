import SwiftUI

// MARK: - WeightViewModel
class WeightViewModel: ObservableObject {
    @Published var selectedWeightKg: Double = 70.0
    @Published var isKgSelected: Bool = true
    @Published var healthBenefitMessage: String = ""
    
    private var lastWeightInOtherUnit: Double = 70.0
    
    var selectedWeightLb: Double {
        selectedWeightKg * 2.20462
    }
    
    var weightInPreferredUnit: Double {
        isKgSelected ? selectedWeightKg : selectedWeightLb
    }
    
    func calculateBMI(heightInCm: Double) -> Double {
        let heightInM = heightInCm / 100
        return selectedWeightKg / (heightInM * heightInM)
    }
    
    func toggleUnit() {
        isKgSelected.toggle()
        if isKgSelected {
            selectedWeightKg = lastWeightInOtherUnit / 2.20462
        } else {
            lastWeightInOtherUnit = selectedWeightKg
            selectedWeightKg = selectedWeightKg * 2.20462
        }
        selectedWeightKg = max(20, min(200, selectedWeightKg))
        updateHealthBenefitMessage()
    }
    
    func updateHealthBenefitMessage() {
        let weightLossPercentage = ((85.0 - selectedWeightKg) / 85.0) * 100
        healthBenefitMessage = """
        Great choice!
        You will lose \(String(format: "%.1f", weightLossPercentage))% of body weight
        You will gain continuous health benefits:
        - Lower blood lipids and blood pressure
        - Boost your metabolism
        """
    }
    
    func updateWeight(newWeight: Double) {
        selectedWeightKg = newWeight
        lastWeightInOtherUnit = selectedWeightLb
        updateHealthBenefitMessage()
    }
}

