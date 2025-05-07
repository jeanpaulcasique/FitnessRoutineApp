import SwiftUI

// MARK: - GymEquipmentViewModel
class GymEquipmentViewModel: ObservableObject {
    /// Opciones de equipamiento disponibles
    enum EquipmentOption: Int, CaseIterable {
        case bodyweightOnly = 0
        case gymEquipment    = 1
    }

    /// Opción seleccionada como enum
    @Published var selectedOption: EquipmentOption? = nil {
        didSet {
            // Persistir la selección
            if let option = selectedOption {
                UserDefaults.standard.set(option.rawValue, forKey: "selectedEquipmentOption")
                selectedIndex = option.rawValue
            } else {
                UserDefaults.standard.removeObject(forKey: "selectedEquipmentOption")
                selectedIndex = nil
            }
        }
    }

    /// Índice de la opción seleccionada (0 o 1)
    @Published var selectedIndex: Int? = nil {
        didSet {
            // Persistir índice por compatibilidad
            if let idx = selectedIndex {
                UserDefaults.standard.set(idx, forKey: "selectedEquipmentIndex")
            } else {
                UserDefaults.standard.removeObject(forKey: "selectedEquipmentIndex")
            }
        }
    }

    init() {
        // Cargar la selección previa desde UserDefaults
        if let raw = UserDefaults.standard.value(forKey: "selectedEquipmentOption") as? Int,
           let option = EquipmentOption(rawValue: raw) {
            self.selectedOption = option
            self.selectedIndex  = raw
        }
    }

    /// Selecciona la opción por índice
    func selectOption(_ index: Int) {
        if let option = EquipmentOption(rawValue: index) {
            self.selectedOption = option
        }
    }

    /// Selecciona la opción por enum
    func selectOption(_ option: EquipmentOption) {
        self.selectedOption = option
    }
}

