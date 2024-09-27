import SwiftUI


@main
struct FitnessRoutineAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: LoginViewModel()) 
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
