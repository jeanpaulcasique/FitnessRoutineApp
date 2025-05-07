import Foundation

/// Gestiona el estado de sesión del usuario usando UserDefaults.
/// Métodos públicos: `login()` y `logout()`.
final class UserSessionManager: ObservableObject {
    @Published var isLoggedIn: Bool

    init() {
        // Registrar valor por defecto para evitar estados indeterminados
        UserDefaults.standard.register(defaults: ["isLoggedIn": false])
        // Carga inicial
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    }

    /// Marca al usuario como conectado.
    func login() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        isLoggedIn = true
    }

    /// Cierra la sesión del usuario.
    func logout() {
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        isLoggedIn = false
    }
}

