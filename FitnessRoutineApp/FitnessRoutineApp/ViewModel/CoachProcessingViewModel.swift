import SwiftUI

class CoachProcessingViewModel: ObservableObject {
    @Published var progress: Double = 1.0
    let tasks: [(text: String, value: String)] = [
        ("Analyzing your body", "191 cm, 0.0 kg"),
        ("Calculating metabolism", "1024 kcal"),
        ("Adapting workout area", "Arm"),
        ("Adjusting fitness level", "Beginner")
    ]
}

