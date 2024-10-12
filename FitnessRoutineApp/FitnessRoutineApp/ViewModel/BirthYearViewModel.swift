import SwiftUI
import Combine

class BirthYearViewModel: ObservableObject {
    @Published var selectedYear: Int = Calendar.current.component(.year, from: Date()) // Valor predeterminado al año actual
    
    @Published var isYearValid: Bool = false // Bandera para controlar si el año es válido

    var canProceed: Bool {
        // Verifica si el año es válido
        return isYearValid
    }

    init() {
        // Configuración inicial
        validateYearSelection()
    }
    
    // Validación del año seleccionado
    private func validateYearSelection() {
        let currentYear = Calendar.current.component(.year, from: Date())
        isYearValid = selectedYear >= 1900 && selectedYear <= currentYear
    }
    
    // Método para seleccionar un año y realizar alguna lógica adicional si es necesario
    func selectYear(_ year: Int) {
        selectedYear = year
        validateYearSelection() // Validar el año cada vez que se selecciona
    }
}

