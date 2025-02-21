import SwiftUI

// MARK: - NewScreenViewModel
class NewScreenViewModel: ObservableObject {
    @Published var options: [(title: String, icon: String)] = [
        ("At home", "house"),
        ("At the gym", "figure.walk"),
        ("Any place is ok", "hand.thumbsup")
    ]
    
    @Published var selectedIndex: Int? {
        didSet {
            // Guardar la selección en UserDefaults
            UserDefaults.standard.set(selectedIndex, forKey: "workoutLocationSelection")
        }
    }
    
    init() {
        // Recuperar la selección guardada desde UserDefaults
        if let savedSelection = UserDefaults.standard.value(forKey: "workoutLocationSelection") as? Int {
            self.selectedIndex = savedSelection
        } else {
            self.selectedIndex = nil // Valor predeterminado (ninguna opción seleccionada)
        }
    }
    
    func selectOption(at index: Int) {
        selectedIndex = index
    }
}

