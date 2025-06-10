import CoreData
import Foundation

class UserManager {
    private let context = PersistenceController.shared.container.viewContext

    // Guardar un usuario
    func saveUser(gender: String, goals: String, weight: Double, age: Int16) {
        let newUser = User(context: context)
        newUser.id = UUID()
        newUser.gender = gender
        newUser.goals = goals
        newUser.weight = weight
        newUser.age = age

        do {
            try context.save()
            print("User saved successfully!")
        } catch {
            print("Error saving user: \(error.localizedDescription)")
        }
    }

    // Recuperar todos los usuarios
    func fetchUsers() -> [User] {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()

        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
            return []
        }
    }

    // Eliminar un usuario
    func deleteUser(_ user: User) {
        context.delete(user)

        do {
            try context.save()
            print("User deleted successfully!")
        } catch {
            print("Error deleting user: \(error.localizedDescription)")
        }
    }
}

/// Gestiona el estado de sesión del usuario y el progreso de onboarding usando UserDefaults.
/// Métodos públicos: login(), logout(), completeOnboarding(), resetUserData()
final class UserSessionManager: ObservableObject {
    @Published var isLoggedIn: Bool
    @Published var hasCompletedOnboarding: Bool
    @Published var isFirstTime: Bool
    
    // Keys para UserDefaults
    private let isLoggedInKey = "isLoggedIn"
    private let hasCompletedOnboardingKey = "hasCompletedOnboarding"
    private let isFirstTimeKey = "isFirstTime"
    
    init() {
        // Registrar valores por defecto
        UserDefaults.standard.register(defaults: [
            isLoggedInKey: false,
            hasCompletedOnboardingKey: false,
            isFirstTimeKey: true
        ])
        
        // Carga inicial
        self.isLoggedIn = UserDefaults.standard.bool(forKey: isLoggedInKey)
        self.hasCompletedOnboarding = UserDefaults.standard.bool(forKey: hasCompletedOnboardingKey)
        self.isFirstTime = UserDefaults.standard.bool(forKey: isFirstTimeKey)
    }
    
    // MARK: - Public Methods
    
    /// Marca al usuario como conectado.
    func login() {
        UserDefaults.standard.set(true, forKey: isLoggedInKey)
        isLoggedIn = true
    }
    
    /// Cierra la sesión del usuario y resetea el estado para forzar el onboarding.
    func logout() {
        // Resetear el estado de login
        UserDefaults.standard.set(false, forKey: isLoggedInKey)
        UserDefaults.standard.set(false, forKey: hasCompletedOnboardingKey)
        UserDefaults.standard.set(true, forKey: isFirstTimeKey)
        
        // Actualizar las variables publicadas
        isLoggedIn = false
        hasCompletedOnboarding = false
        isFirstTime = true
        
        // Limpiar datos del usuario
        clearUserProfileData()
    }
    
    /// Marca el onboarding como completado.
    func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: hasCompletedOnboardingKey)
        UserDefaults.standard.set(false, forKey: isFirstTimeKey)
        hasCompletedOnboarding = true
        isFirstTime = false
    }
    
    /// Resetea todos los datos del usuario (útil para testing o reset completo).
    func resetUserData() {
        UserDefaults.standard.set(false, forKey: isLoggedInKey)
        UserDefaults.standard.set(false, forKey: hasCompletedOnboardingKey)
        UserDefaults.standard.set(true, forKey: isFirstTimeKey)
        
        isLoggedIn = false
        hasCompletedOnboarding = false
        isFirstTime = true
        
        // También puedes limpiar otros datos del usuario aquí
        clearUserProfileData()
    }
    
    /// Resetea solo el onboarding (para forzar que vuelva a pasar por el flujo).
    func resetOnboarding() {
        UserDefaults.standard.set(false, forKey: hasCompletedOnboardingKey)
        UserDefaults.standard.set(true, forKey: isFirstTimeKey)
        hasCompletedOnboarding = false
        isFirstTime = true
    }
    
    // MARK: - Computed Properties
    
    /// Determina si el usuario debe ir al onboarding o al dashboard.
    var shouldShowOnboarding: Bool {
        return !hasCompletedOnboarding || isFirstTime || !isLoggedIn
    }
    
    /// Determina si el usuario está completamente configurado.
    var isUserSetupComplete: Bool {
        return isLoggedIn && hasCompletedOnboarding && !isFirstTime
    }
    
    // MARK: - Private Methods
    
    /// Limpia todos los datos del perfil del usuario.
    private func clearUserProfileData() {
        let userDataKeys = [
            "gender", "selectedHeightCm", "selectedHeightFt", "selectedHeightInch",
            "selectedWeightKg", "selectedTargetWeight", "selectedGoal", "selectedTarget",
            "equipmentPreference", "bodyCurrentImage", "desiredBodyImage",
            "selectedBirthYear", "selectedWorkoutLevel", "selectedLevelActivity",
            "selectedHowOften", "selectedDietType", "profile_image_data",
            "total_workouts", "current_streak", "achieved_goals",
            "user_subscription", "user_referral_code"
        ]
        
        userDataKeys.forEach { key in
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
    
    // MARK: - Debug Helpers
    
    /// Imprime el estado actual para debugging.
    func printCurrentState() {
        print("=== UserSessionManager State ===")
        print("isLoggedIn: \(isLoggedIn)")
        print("hasCompletedOnboarding: \(hasCompletedOnboarding)")
        print("isFirstTime: \(isFirstTime)")
        print("shouldShowOnboarding: \(shouldShowOnboarding)")
        print("isUserSetupComplete: \(isUserSetupComplete)")
        print("================================")
    }
}
