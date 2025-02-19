import SwiftUI
import Combine

// MARK: - BirthYearViewModel
class BirthYearViewModel: ObservableObject {
    @Published var selectedYear: Int = Calendar.current.component(.year, from: Date())
    private var cancellables = Set<AnyCancellable>()
    
    var birthYearRange: [Int] {
        let currentYear = Calendar.current.component(.year, from: Date())
        return Array(1900...currentYear)
    }
    
    var canProceed: Bool {
        validateYear(selectedYear)
    }
    
    init() {
        $selectedYear
            .sink { [weak self] _ in _ = self?.canProceed }
            .store(in: &cancellables)
    }
    
    private func validateYear(_ year: Int) -> Bool {
        let currentYear = Calendar.current.component(.year, from: Date())
        return year >= 1900 && year <= currentYear
    }
    
    func selectYear(_ year: Int) {
        selectedYear = year
    }
}

