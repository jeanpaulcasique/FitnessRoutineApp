import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String?
    @Published var showLoginOptions: Bool = false
    @Published var isLoading: Bool = false
    @Published var isDisabled: Bool = false
    @Published var navigateToFase1: Bool = false

    // MARK: - Login Actions

    func handleStartButtonTap(sessionManager: UserSessionManager) -> () -> Void {
        return {
            guard !self.isDisabled else { return }

            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()

            self.isDisabled = true
            self.isLoading = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sessionManager.login()
                self.navigateToFase1 = true
                self.isLoading = false
            }
        }
    }

    func resetButton() {
        isDisabled = false
        isLoading = false
    }

    func showExistingAccountOptions() {
        showLoginOptions = true
        print("Opciones de cuenta existente desplegadas")
    }

    func hideLoginOptions() {
        showLoginOptions = false
    }

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

    private func performLogin(completion: @escaping () -> Void) {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isLoading = false
            if Bool.random() {
                self.isLoggedIn = true
                completion()
            } else {
                self.errorMessage = "Error en el inicio de sesión. Inténtalo de nuevo."
                print(self.errorMessage ?? "")
            }
        }
    }
}

