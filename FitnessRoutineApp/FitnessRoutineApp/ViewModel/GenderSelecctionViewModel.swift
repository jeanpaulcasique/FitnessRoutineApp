import SwiftUI

// MARK: - Gender Enum
enum Gender: String {
    case male = "male"
    case female = "female"
}

// MARK: - GenderSelectionViewModel
class GenderSelectionViewModel: ObservableObject {
    @Published var selectedGender: Gender? = nil
    
    func selectGender(_ gender: Gender) {
        selectedGender = gender
        #if USE_COREDATA
        UserManager.shared.updateGender(gender.rawValue)
        #else
        print("Género seleccionado: \(gender.rawValue)")
        #endif
    }
}

