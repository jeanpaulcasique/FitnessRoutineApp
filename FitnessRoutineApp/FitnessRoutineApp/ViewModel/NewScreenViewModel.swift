import SwiftUI

class NewScreenViewModel: ObservableObject {
    // Opciones disponibles
    @Published var options: [(title: String, icon: String)] = [
        ("At home", "house"),
        ("At the gym", "figure.walk"),
        ("Outdoors", "sun.max"),
        ("Any place is ok", "hand.thumbsup")
    ]
    
    // Índice de la opción seleccionada
    @Published var selectedIndex: Int? = nil

    // Función para seleccionar una opción
    func selectOption(at index: Int) {
        selectedIndex = index
    }
}
