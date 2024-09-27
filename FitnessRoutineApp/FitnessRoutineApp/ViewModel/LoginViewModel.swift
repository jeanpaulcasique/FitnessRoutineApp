import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String?
    @Published var showLoginOptions: Bool = false // Controla la visibilidad del cuadro de login
    @Published var showExistingAccount = false

    // Función para simular el inicio de sesión con Apple
    func signInWithApple() {
        performLogin {
            print("Inicio de sesión simulado con Apple exitoso")
        }
    }

    // Función para simular el inicio de sesión con Google
    func signInWithGoogle() {
        performLogin {
            print("Inicio de sesión simulado con Google exitoso")
        }
    }

    // Función para simular el inicio de sesión con Facebook
    func signInWithFacebook() {
        performLogin {
            print("Inicio de sesión simulado con Facebook exitoso")
        }
    }

    // Función para mostrar las opciones de cuenta existente
    func showExistingAccountOptions() {
        DispatchQueue.main.async {
            self.showLoginOptions = true
            print("Opciones de cuenta existente desplegadas")
        }
    }

    // Función para ocultar las opciones de inicio de sesión
    func hideLoginOptions() {
        DispatchQueue.main.async {
            self.showLoginOptions = false
        }
    }

    // Función privada para manejar el inicio de sesión simulado
    private func performLogin(completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isLoggedIn = true
            completion() // Llama al bloque de finalización para imprimir el mensaje
        }
    }
}

