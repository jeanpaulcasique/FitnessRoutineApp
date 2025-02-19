import SwiftUI

// MARK: - NewScreenViewModel
class NewScreenViewModel: ObservableObject {
    @Published var options: [(title: String, icon: String)] = [
        ("At home", "house"),
        ("At the gym", "figure.walk"),
       
        ("Any place is ok", "hand.thumbsup")
    ]
    
    @Published var selectedIndex: Int? = nil
    
    func selectOption(at index: Int) {
        selectedIndex = index
    }
}

