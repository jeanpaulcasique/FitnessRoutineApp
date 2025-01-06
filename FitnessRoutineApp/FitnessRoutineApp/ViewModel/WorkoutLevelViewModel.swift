import SwiftUI

class WorkoutLevelViewModel: ObservableObject {
    // Opciones de niveles de ejercicio
    let levels = [
        ("Easy to start", "hand.point.up.left.fill"),
        ("Break a light sweat", "drop.fill"),
        ("A bit challenging", "figure.strengthtraining.traditional")
    ]

    @Published var selectedIndex: Int? = 0 // Índice seleccionado, por defecto el primero

    func selectLevel(at index: Int) {
        selectedIndex = index
    }
}
