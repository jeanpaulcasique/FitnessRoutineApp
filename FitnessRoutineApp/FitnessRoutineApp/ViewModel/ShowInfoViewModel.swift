import Foundation
import SwiftUI

class ShowInfoViewModel: ObservableObject {
    @Published var progress: Double = 0.0
    @Published var visibleItems: Int = 0
    @Published var isPulsing: Bool = true
    @Published var infoItems: [(text: String, value: String)] = []

    func loadData() {
        let gender = UserDefaults.standard.string(forKey: "gender") ?? "Not Set"
        let height: String
        if let storedHeightCm = UserDefaults.standard.value(forKey: "selectedHeightCm") as? Int {
            height = "\(storedHeightCm) cm"
        } else if let storedHeightFt = UserDefaults.standard.value(forKey: "selectedHeightFt") as? Int,
                  let storedHeightInch = UserDefaults.standard.value(forKey: "selectedHeightInch") as? Int {
            height = "\(storedHeightFt) ft \(storedHeightInch) in"
        } else {
            height = "Not Set"
        }

        let weight = UserDefaults.standard.value(forKey: "selectedWeightKg") as? Double ?? 0.0
        let targetWeight = UserDefaults.standard.value(forKey: "selectedTargetWeight") as? Double ?? 0.0
        let goal = UserDefaults.standard.string(forKey: "selectedGoal") ?? "Not Set"
        let equipmentPreference = UserDefaults.standard.string(forKey: "equipmentPreference") ?? "Not Set"
        let bodyCurrent = UserDefaults.standard.string(forKey: "bodyCurrentImage") ?? "Not Set"
        let desiredBody = UserDefaults.standard.string(forKey: "desiredBodyImage") ?? "Not Set"
        let birthYear = UserDefaults.standard.string(forKey: "selectedBirthYear") ?? "Not Set"
        let target = UserDefaults.standard.string(forKey: "selectedTarget") ?? "Not Set"
        let workoutLevel = UserDefaults.standard.string(forKey: "selectedWorkoutLevel") ?? "Not Set"
        let levelActivity = UserDefaults.standard.string(forKey: "selectedLevelActivity") ?? "Not Set"
        let howOften = UserDefaults.standard.string(forKey: "selectedHowOften") ?? "Not Set"

        infoItems = [
            ("Gender", gender),
            ("Height", height),
            ("Weight", String(format: "%.1f kg", weight)),
            ("Goal", goal),
            ("Target", target),
            ("Equipment Preference", equipmentPreference),
            ("Body Current", bodyCurrent),
            ("Desired Body", desiredBody),
            ("Birth Year", birthYear),
            ("Workout Level", workoutLevel),
            ("Level Activity", levelActivity),
            ("How Often", howOften)
        ]
    }

    func startProgress() {
        for i in 0..<infoItems.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.4) { [weak self] in
                guard let self = self else { return }
                withAnimation {
                    self.visibleItems += 1
                    self.progress = Double(self.visibleItems) / Double(self.infoItems.count)
                }
            }
        }
    }
}
