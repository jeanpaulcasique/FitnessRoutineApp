import SwiftUI
import Combine

class HowOftenViewModel: ObservableObject {
    @Published var currentIndex = 0
    let imageNames = ["1time", "2time", "3time", "4time"]
    let descriptions = [
        "I'm so busy, and would like to work out once in a while",
        "I would like to work out a few times a week",
        "I’m motivated to exercise almost every day",
        "I'm committed to daily workouts for optimal results"
    ]
    
    var imageCount: Int {
        imageNames.count
    }
    
    var currentImageName: String {
        imageNames[currentIndex]
    }
    
    var descriptionText: String {
        descriptions[currentIndex]
    }
    
    func nextImage() {
        if currentIndex < imageNames.count - 1 {
            currentIndex += 1
        }
    }
    
    func previousImage() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }
}

