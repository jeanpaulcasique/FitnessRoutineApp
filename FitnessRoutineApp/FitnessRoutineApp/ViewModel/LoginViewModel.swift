import SwiftUI
class LoginViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String?
    @Published var showLoginOptions: Bool = false
    @Published var isLoggingIn: Bool = false  // Indica si se está iniciando sesión

    func signInWithApple() {
        performLogin {
            print("Inicio de sesión simulado con Apple exitoso")
        }
    }

    func signInWithGoogle() {
        performLogin {
            print("Inicio de sesión simulado con Google exitoso")
        }
    }

    func signInWithFacebook() {
        performLogin {
            print("Inicio de sesión simulado con Facebook exitoso")
        }
    }

    func showExistingAccountOptions() {
        showLoginOptions = true
        print("Opciones de cuenta existente desplegadas")
    }

    func hideLoginOptions() {
        showLoginOptions = false
    }

    private func performLogin(completion: @escaping () -> Void) {
        isLoggingIn = true  // Inicia el estado de carga
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isLoggingIn = false  // Termina el estado de carga
            // Simula un error aleatorio en el inicio de sesión
            if Bool.random() {
                self.isLoggedIn = true
                completion()  // Llama al bloque de finalización
            } else {
                self.errorMessage = "Error en el inicio de sesión. Inténtalo de nuevo."
                print(self.errorMessage ?? "")
            }
        }
    }
}
