import SwiftUI

class WorkoutViewModel: ObservableObject {
    @Published var recommendedWorkouts = ["Push-ups", "HIIT", "YogaFlow"]
    @Published var fullBodyWorkouts = ["Burpees", "Kettlebell", "FullCircuit"]
    @Published var upperBodyWorkouts = ["Pull-ups", "DumbbellPress"]
    @Published var legDayWorkouts = ["Squats", "Lunges", "Deadlift"]

    // MARK: - Filter Function
    func filteredWorkouts(_ workouts: [String], searchText: String) -> [String] {
        if searchText.isEmpty {
            return workouts
        } else {
            return workouts.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }
}

