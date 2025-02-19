import SwiftUI
import Combine

// MARK: - WorkoutLevelViewModel
class WorkoutLevelViewModel: ObservableObject {
    let levels = [
        ("Easy to start", "hand.point.up.left.fill"),
        ("Break a light sweat", "drop.fill"),
        ("A bit challenging", "figure.strengthtraining.traditional")
    ]
    
    @Published var selectedIndex: Int? = 0
    
    func selectLevel(at index: Int) {
        selectedIndex = index
    }
}

