import SwiftUI

@main
struct FitnessRoutineAppApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var progressViewModel = ProgressViewModel()  // Crear el ViewModel

    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: LoginViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(progressViewModel)  // Pasar el ProgressViewModel como un environment object
        }
    }
}
