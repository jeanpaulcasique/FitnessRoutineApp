import SwiftUI

class BodyCurrentViewModel: ObservableObject {
    @Published var selectedBodyShape: BodyShape?

    enum BodyShape {
        case medium
        case flabby
        case skinny
        case muscular
    }

    // Función para seleccionar la forma corporal
    func selectBodyShape(_ shape: BodyShape) {
        selectedBodyShape = shape
    }
}
