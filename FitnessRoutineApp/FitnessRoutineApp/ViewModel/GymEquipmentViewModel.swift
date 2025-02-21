import SwiftUI

class GymEquipmentViewModel: ObservableObject {
    // Opciones de equipamiento disponibles
    enum EquipmentOption {
        case bodyweightOnly
        case gymEquipment
        case none
    }
    
    @Published var selectedOption: EquipmentOption = .none
    @Published var selectedIndex: Int? = nil
        
        func selectOption(_ index: Int) {
            selectedIndex = index
        }
    // Función para actualizar la opción elegida
    func selectOption(_ option: EquipmentOption) {
        selectedOption = option
    }
}
