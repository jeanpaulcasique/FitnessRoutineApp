

import SwiftUI

class LevelActivityViewModel: ObservableObject {
    @Published var sliderValue: Double = 0 {
        didSet {
            updateActivityLevel()
        }
    }
    
    @Published var currentImageName: String = "1level"
    @Published var activityDescription: String = "I sit at my desk all day"
    
    private let imageNames = ["1level", "2level", "3level", "4level"]
    private let descriptions = [
        "I sit at my desk all day",
        "I occasionally exercise or walk for 30 minutes",
        "I love working out, and want to get more exercises",
        "I am very active and work out daily"
    ]
    
    private func updateActivityLevel() {
        let index = Int(sliderValue)
        currentImageName = imageNames[index]
        activityDescription = descriptions[index]
    }
    
    func nextAction() {
        // Acción del botón "Next"
    }
}
