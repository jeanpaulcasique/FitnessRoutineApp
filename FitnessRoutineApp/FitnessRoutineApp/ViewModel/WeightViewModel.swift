import SwiftUI

class WeightViewModel: ObservableObject {
    @Published var selectedWeightKg: Double = 70.0 // Peso inicial
    @Published var isKgSelected: Bool = true // Para manejar la selección entre kg y lb
    @Published var healthBenefitMessage: String = ""
    
    // Variable para almacenar el peso en la unidad anterior
    private var lastWeightInOtherUnit: Double = 70.0
    
    var selectedWeightLb: Double {
        return selectedWeightKg * 2.20462
    }
    
    var weightInPreferredUnit: Double {
        return isKgSelected ? selectedWeightKg : selectedWeightLb
    }

    // Calcular el IMC
    func calculateBMI(heightInCm: Double) -> Double {
        let heightInM = heightInCm / 100 // Convertir altura a metros
        return selectedWeightKg / (heightInM * heightInM) // Fórmula del IMC
    }

    func toggleUnit() {
        isKgSelected.toggle()
        
        // Al cambiar de unidad, actualizamos el peso seleccionado en la nueva unidad
        if isKgSelected {
            // Convertir lb a kg y usar el peso almacenado
            selectedWeightKg = lastWeightInOtherUnit / 2.20462
        } else {
            // Convertir kg a lb y usar el peso almacenado
            lastWeightInOtherUnit = selectedWeightKg
            selectedWeightKg = selectedWeightKg * 2.20462
        }
        
        // Asegurarse de que los límites sean respetados
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
        // Al actualizar el peso, también guardamos el valor en la otra unidad
        lastWeightInOtherUnit = selectedWeightLb
        updateHealthBenefitMessage()
    }
}

