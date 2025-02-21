import SwiftUI
class BodyCurrentViewModel: ObservableObject {
    @Published var selectedBodyShape: BodyShape?

    enum BodyShape: String, CaseIterable, Identifiable {
        case medium = "mediumMen"
        case flabby = "flabbyMen"
        case skinny = "skinnyMen"
        case muscular = "muscularMen"
        
        var id: String { self.rawValue }
    }

    func selectBodyShape(_ shape: BodyShape) {
        // Si seleccionamos la misma forma, la desmarcamos, sino la marcamos
        selectedBodyShape = (selectedBodyShape == shape) ? nil : shape
        
        // Guardamos el nombre de la imagen en UserDefaults
        if let selectedShape = selectedBodyShape {
            UserDefaults.standard.set(selectedShape.rawValue, forKey: "bodyCurrentImage")
        } else {
            // Si no hay forma seleccionada, eliminamos el valor de UserDefaults
            UserDefaults.standard.removeObject(forKey: "bodyCurrentImage")
        }
    }
    
    init() {
        // No se cargan datos de UserDefaults en el inicio
    }
}
