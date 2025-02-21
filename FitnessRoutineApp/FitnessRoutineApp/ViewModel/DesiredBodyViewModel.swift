
import SwiftUI


class DesiredBodyViewModel: ObservableObject {
    @Published var selectedBodyIndex: Int
    
    // Listado de imágenes que representa las formas corporales
    let bodyImages = ["1m", "2m", "3m", "4m", "5m", "6m", "7m"]

    // Rango de grasa corporal para las distintas formas
    let bodyFatRanges = [
        "4% ~ 6% (Reasonable Goal!)",
        "7% ~ 10% (Reasonable Goal!)",
        "11% ~ 15% (That's good!)",
        "16% ~ 23% (Reasonable Goal!)",
        "24% ~ 30% (Consult a doctor)",
        "31% ~ 40% (Consult a doctor)",
        ">40% (Consult a doctor)"
    ]
    
    // Descripciones relacionadas con cada rango de grasa corporal
    let bodyFatDescriptions = [
        "Step by step! This goal is practical and friendly for beginners.",
        "Step by step! This goal is practical and friendly for beginners.",
        "You are already in your target zone. Just keep it up!",
        "Step by step! This goal is practical and friendly for beginners.",
        "This body fat level seems too high for you, which might cause some health issues.",
        "This body fat level seems too high for you, which might cause some health issues.",
        "This body fat level seems too high for you, which might cause some health issues."
    ]
    
    init() {
        self.selectedBodyIndex = 0 // Default to first index
    }
}
