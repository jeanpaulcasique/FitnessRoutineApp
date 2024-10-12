import Foundation
import SwiftUI

class GoalViewModel: ObservableObject {
    @Published var selectedGoal: Goal?

    // Enum para los objetivos, usando String para facilitar el almacenamiento
    enum Goal: String {
        case loseWeight = "Lose Weight"
        case buildMuscle = "Build Muscle"
        case keepFit = "Keep Fit"
    }

    // Función para seleccionar un objetivo
    func selectGoal(_ goal: Goal) {
        print("Objetivo seleccionado: \(goal.rawValue)")  // Depuración
        selectedGoal = goal
    }

    // Función para guardar el objetivo del usuario
    func saveUserGoal() {
        guard let selectedGoal = selectedGoal else {
            print("Error: No se ha seleccionado ningún objetivo.")
            return
        }

        // Simulación de almacenamiento
        print("Usuario guardó el objetivo: \(selectedGoal.rawValue)")

        // Implementación para almacenar el objetivo
        storeGoalInCoreData(selectedGoal)
        // O si estás usando Firebase:
        // storeGoalInFirebase(selectedGoal)
    }

    // Simulación de almacenamiento en Core Data
    private func storeGoalInCoreData(_ goal: Goal) {
        // Implementa aquí el código para almacenar en Core Data
        // Ejemplo: crear una entidad y guardar el valor
        print("Guardando \(goal.rawValue) en Core Data.")
    }

    // Simulación de almacenamiento en Firebase
    private func storeGoalInFirebase(_ goal: Goal) {
        // Implementa aquí el código para almacenar en Firebase
        // Ejemplo: subir los datos a una colección de Firestore
        print("Guardando \(goal.rawValue) en Firebase.")
    }
}

