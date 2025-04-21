import SwiftUI

// MARK: - WeightViewModel
class WeightViewModel: ObservableObject {
    @Published var selectedWeightKg: Double {
        didSet {
            UserDefaults.standard.set(selectedWeightKg, forKey: "selectedWeightKg")
        }
    }
    
    @Published var isKgSelected: Bool {
        didSet {
            UserDefaults.standard.set(isKgSelected, forKey: "isKgSelected")
        }
    }
    
    @Published var healthBenefitMessage: String = ""
    
    var selectedWeightLb: Double {
        get { selectedWeightKg * 2.20462 }
        set { selectedWeightKg = newValue / 2.20462 }
    }
    
    var weightInPreferredUnit: Double {
        isKgSelected ? selectedWeightKg : selectedWeightLb
    }

    init() {
        if let savedWeight = UserDefaults.standard.value(forKey: "selectedWeightKg") as? Double {
            self.selectedWeightKg = savedWeight
        } else {
            self.selectedWeightKg = 70.0
        }
        
        if let savedUnit = UserDefaults.standard.value(forKey: "isKgSelected") as? Bool {
            self.isKgSelected = savedUnit
        } else {
            self.isKgSelected = true
        }
        
        updateHealthBenefitMessage()
    }

    func calculateBMI(heightInCm: Double) -> Double {
        let heightInM = heightInCm / 100
        return selectedWeightKg / (heightInM * heightInM)
    }
    
    func toggleUnit() {
        if isKgSelected {
            // Convertir de kg a lb y mantener el mismo valor perceptivo
            let currentKg = selectedWeightKg
            isKgSelected = false
            selectedWeightLb = currentKg * 2.20462 // esto actualiza selectedWeightKg con su equivalente en lb
        } else {
            // Convertir de lb a kg y mantener el mismo valor perceptivo
            let currentLb = selectedWeightLb
            isKgSelected = true
            selectedWeightKg = currentLb / 2.20462
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
        if isKgSelected {
            selectedWeightKg = newWeight
        } else {
            selectedWeightLb = newWeight
        }
        updateHealthBenefitMessage()
    }
}

