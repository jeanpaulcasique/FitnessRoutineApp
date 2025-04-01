import SwiftUI
import Combine

// MARK: - WorkoutLevelViewModel
class WorkoutLevelViewModel: ObservableObject {
    let levels = [
        ("Easy to start", "hand.point.up.left.fill"),
        ("Break a light sweat", "drop.fill"),
        ("A bit challenging", "figure.strengthtraining.traditional")
    ]
    
    @Published var selectedIndex: Int? {
        didSet {
            // Guardar la selección en UserDefaults
            UserDefaults.standard.set(selectedIndex, forKey: "workoutLevelSelection")
        }
    }
    
    init() {
        // Recuperar la selección guardada desde UserDefaults
        if let savedSelection = UserDefaults.standard.value(forKey: "workoutLevelSelection") as? Int {
            self.selectedIndex = savedSelection
        } else {
            self.selectedIndex = 0 // Valor predeterminado
        }
    }
    
    func selectLevel(at index: Int) {
        selectedIndex = index
    }
}

