import Foundation
#if USE_COREDATA
import CoreData
#endif

class UserManager: ObservableObject {
    static let shared = UserManager()
    
    #if USE_COREDATA
    private let context = PersistenceController.shared.container.viewContext
    @Published var currentUser: User?
    
    private init() {
        loadOrCreateUser()
    }
    
    /// Intenta cargar un usuario existente; si no existe, crea uno nuevo.
    private func loadOrCreateUser() {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users = try context.fetch(request)
            if let user = users.first {
                currentUser = user
            } else {
                let newUser = User(context: context)
                // Asigna un valor predeterminado para birthYear (puedes agregar más según tus necesidades)
                newUser.birthYear = Int16(Calendar.current.component(.year, from: Date()))
                currentUser = newUser
                save()
            }
        } catch {
            print("Error al cargar el usuario: \(error)")
        }
    }
    
    /// Guarda el contexto de Core Data.
    private func save() {
        do {
            try context.save()
        } catch {
            print("Error al guardar el usuario: \(error)")
        }
    }
    
    // Métodos para actualizar cada propiedad del usuario
    func updateGender(_ gender: String) {
        currentUser?.gender = gender
        save()
    }
    
    func updateGoal(_ goal: String) {
        currentUser?.goal = goal
        save()
    }
    
    func updateCurrentBodyShape(_ shape: String) {
        currentUser?.currentBodyShape = shape
        save()
    }
    
    func updateDesiredBodyShape(_ shape: String) {
        currentUser?.desiredBodyShape = shape
        save()
    }
    
    func updateBirthYear(_ year: Int) {
        currentUser?.birthYear = Int16(year)
        save()
    }
    
    func updateHeight(_ height: Double) {
        currentUser?.height = height
        save()
    }
    #else
    // Si no usas Core Data, estas funciones solo muestran mensajes en la consola.
    init() {}
    
    func updateGender(_ gender: String) {
        print("Core Data deshabilitado. updateGender: \(gender)")
    }
    
    func updateGoal(_ goal: String) {
        print("Core Data deshabilitado. updateGoal: \(goal)")
    }
    
    func updateCurrentBodyShape(_ shape: String) {
        print("Core Data deshabilitado. updateCurrentBodyShape: \(shape)")
    }
    
    func updateDesiredBodyShape(_ shape: String) {
        print("Core Data deshabilitado. updateDesiredBodyShape: \(shape)")
    }
    
    func updateBirthYear(_ year: Int) {
        print("Core Data deshabilitado. updateBirthYear: \(year)")
    }
    
    func updateHeight(_ height: Double) {
        print("Core Data deshabilitado. updateHeight: \(height)")
    }
    #endif
}

