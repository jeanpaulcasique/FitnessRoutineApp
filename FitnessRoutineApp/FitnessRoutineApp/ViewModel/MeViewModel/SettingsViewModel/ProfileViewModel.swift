import SwiftUI
import UIKit

class ProfileViewModel: ObservableObject {
    @Published var infoItems: [ProfileItem] = []
    @Published var profileImage: UIImage?
    @Published var showPhotoOptions = false
    @Published var showImagePicker = false
    @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary

    init() {
        loadData()
    }

    func loadData() {
        let defaults = UserDefaults.standard

        let gender = defaults.string(forKey: "gender") ?? "Not Set"
        let height: String
        if let storedHeightCm = defaults.value(forKey: "selectedHeightCm") as? Int {
            height = "\(storedHeightCm) cm"
        } else if let storedHeightFt = defaults.value(forKey: "selectedHeightFt") as? Int,
                  let storedHeightInch = defaults.value(forKey: "selectedHeightInch") as? Int {
            height = "\(storedHeightFt) ft \(storedHeightInch) in"
        } else {
            height = "Not Set"
        }

        let weight = defaults.value(forKey: "selectedWeightKg") as? Double ?? 0.0
        let targetWeight = defaults.value(forKey: "selectedTargetWeight") as? Double ?? 0.0
        let goal = defaults.string(forKey: "selectedGoal") ?? "Not Set"
        let target = defaults.string(forKey: "selectedTarget") ?? "Not Set"
        let equipmentPreference = defaults.string(forKey: "equipmentPreference") ?? "Not Set"
        let bodyCurrent = defaults.string(forKey: "bodyCurrentImage") ?? "Not Set"
        let desiredBody = defaults.string(forKey: "desiredBodyImage") ?? "Not Set"
        let birthYear = defaults.string(forKey: "selectedBirthYear") ?? "Not Set"
        let workoutLevel = defaults.string(forKey: "selectedWorkoutLevel") ?? "Not Set"
        let levelActivity = defaults.string(forKey: "selectedLevelActivity") ?? "Not Set"
        let howOften = defaults.string(forKey: "selectedHowOften") ?? "Not Set"

        infoItems = [
            ProfileItem(text: "Gender", value: gender),
            ProfileItem(text: "Height", value: height),
            ProfileItem(text: "Weight", value: String(format: "%.1f kg", weight)),
            ProfileItem(text: "Goal", value: goal),
            ProfileItem(text: "Target", value: target),
            ProfileItem(text: "Equipment Preference", value: equipmentPreference),
            ProfileItem(text: "Body Current", value: bodyCurrent),
            ProfileItem(text: "Desired Body", value: desiredBody),
            ProfileItem(text: "Birth Year", value: birthYear),
            ProfileItem(text: "Workout Level", value: workoutLevel),
            ProfileItem(text: "Level Activity", value: levelActivity),
            ProfileItem(text: "How Often", value: howOften),
      
        ]
    }
}

