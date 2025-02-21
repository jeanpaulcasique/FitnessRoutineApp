import SwiftUI

// MARK: - WeightViewModel
class WeightViewModel: ObservableObject {
    @Published var selectedWeightKg: Double {
        didSet {
            // Guardar el peso cuando cambie
            UserDefaults.standard.set(selectedWeightKg, forKey: "selectedWeightKg")
        }
    }
    @Published var isKgSelected: Bool {
        didSet {
            // Guardar la unidad cuando cambie
            UserDefaults.standard.set(isKgSelected, forKey: "isKgSelected")
        }
    }
    @Published var healthBenefitMessage: String = ""
    
    private var lastWeightInOtherUnit: Double = 70.0
    
    var selectedWeightLb: Double {
        selectedWeightKg * 2.20462
    }
    
    var weightInPreferredUnit: Double {
        isKgSelected ? selectedWeightKg : selectedWeightLb
    }
    
    init() {
        // Recuperar el peso y la unidad de UserDefaults al inicializar
        if let savedWeight = UserDefaults.standard.value(forKey: "selectedWeightKg") as? Double {
            self.selectedWeightKg = savedWeight
        } else {
            self.selectedWeightKg = 70.0 // Valor predeterminado si no se encuentra en UserDefaults
        }
        
        if let savedUnit = UserDefaults.standard.value(forKey: "isKgSelected") as? Bool {
            self.isKgSelected = savedUnit
        } else {
            self.isKgSelected = true // Valor predeterminado si no se encuentra en UserDefaults
        }
        
        updateHealthBenefitMessage()
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

