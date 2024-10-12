import SwiftUI

class BodyCurrentViewModel: ObservableObject {
    @Published var selectedBodyShape: BodyShape?

    // Enum para las formas corporales, ahora conforme a CaseIterable e Identifiable
    enum BodyShape: String, CaseIterable, Identifiable {
        case medium = "mediumMen"
        case flabby = "flabbyMen"
        case skinny = "skinnyMen"
        case muscular = "muscularMen"
        
        var id: String { self.rawValue } // Identificador para el enum
    }

    // Función para seleccionar la forma corporal
    func selectBodyShape(_ shape: BodyShape) {
        // Cambia la selección: si se selecciona de nuevo la misma forma, se deselecciona
        if selectedBodyShape == shape {
            selectedBodyShape = nil
        } else {
            selectedBodyShape = shape
        }
    }
}
