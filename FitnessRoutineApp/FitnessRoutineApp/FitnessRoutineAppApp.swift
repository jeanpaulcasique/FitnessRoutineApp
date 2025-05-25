import SwiftUI

@main
struct FitnessRoutineAppApp: App {
    
    @StateObject private var progressViewModel = ProgressViewModel()
    @StateObject private var sessionManager = UserSessionManager() // ✅ Añadir el UserSessionManager

    var body: some Scene {
        WindowGroup {
            Group {
                if sessionManager.isLoggedIn {
                    // Tu pantalla principal si ya está logueado
                    DashboardView()
                } else {
                    // Si no ha iniciado sesión, muestra el login
                    LoginView(viewModel: LoginViewModel())
                }
            }
            .environmentObject(progressViewModel)
            .environmentObject(sessionManager) // ✅ Pasamos el session manager como environment object
        }
    }
}

