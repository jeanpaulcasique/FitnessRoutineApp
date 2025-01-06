import SwiftUI
import Combine

class BirthYearViewModel: ObservableObject {
    @Published var selectedYear: Int = Calendar.current.component(.year, from: Date()) // Valor predeterminado al año actual
    private var cancellables = Set<AnyCancellable>() // Para la suscripción
    
    // Rango de años disponibles
    var birthYearRange: [Int] {
        let currentYear = Calendar.current.component(.year, from: Date())
        return Array(1900...currentYear)
    }
    
    var canProceed: Bool {
        return validateYear(selectedYear)
    }
    
    init() {
        // Suscribirse a cambios en selectedYear
        $selectedYear
            .sink { [weak self] year in
                // Validar cada vez que se selecciona un nuevo año
                _ = self?.canProceed // Solo para invalidar el valor previamente calculado
            }
            .store(in: &cancellables)
    }
    
    // Validación del año seleccionado
    private func validateYear(_ year: Int) -> Bool {
        let currentYear = Calendar.current.component(.year, from: Date())
        return year >= 1900 && year <= currentYear
    }
    
    // Método para seleccionar un año
    func selectYear(_ year: Int) {
        selectedYear = year // Se validará automáticamente por la suscripción
    }
}

