//
//  FitnessRoutineAppApp.swift
//  FitnessRoutineApp
//
//  Created by Jean Casique on 12/9/24.
//

import SwiftUI

@main
struct FitnessRoutineAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
