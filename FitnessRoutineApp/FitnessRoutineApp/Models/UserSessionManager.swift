import CoreData

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
