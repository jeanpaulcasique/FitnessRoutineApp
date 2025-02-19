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
        if selectedBodyShape == shape {
            selectedBodyShape = nil
        } else {
            selectedBodyShape = shape
        }
    }
}

