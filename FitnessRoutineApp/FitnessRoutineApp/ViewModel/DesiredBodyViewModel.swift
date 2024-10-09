import SwiftUI

class DesiredBodyViewModel: ObservableObject {
    @Published var selectedBodyIndex: Int = 0
    @Published var dragOffset: CGFloat = 0 // Control del desplazamiento
    let bodyImages = ["1m", "2m", "3m", "4m", "5m", "6m", "7m"]
    
    func nextBody() {
        if selectedBodyIndex < bodyImages.count - 1 {
            selectedBodyIndex += 1
        }
    }
    
    func previousBody() {
        if selectedBodyIndex > 0 {
            selectedBodyIndex -= 1
        }
    }
    
    func selectBody(index: Int) {
        selectedBodyIndex = index
    }
}
