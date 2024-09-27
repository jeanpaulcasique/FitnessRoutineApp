import Foundation
import CoreData

// ViewModel for handling Routines
class RoutineViewModel: ObservableObject {
    // Published property to update the view whenever the routines change
    @Published var routines: [Rutina] = []
    
    // Managed object context from Core Data
    private let context: NSManagedObjectContext
    
    // Initializer that sets the context and fetches the routines
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchRoutines() // Load existing routines
    }
    
    // Function to fetch all routines from Core Data
    func fetchRoutines() {
        let request: NSFetchRequest<Rutina> = Rutina.fetchRequest()
        
        do {
            routines = try context.fetch(request)
        } catch {
            print("Error fetching routines: \(error)")
        }
    }
    
    // Function to add a new routine
    func addRoutine(name: String, createdDate: Date) {
        let newRoutine = Rutina(context: context)
        newRoutine.name = name
        newRoutine.createdDate = createdDate
        
        // Save the context after adding the new routine
        saveContext()
    }
    
    // Function to save changes to Core Data
    private func saveContext() {
        do {
            try context.save() // Attempt to save the context
        } catch {
            // Handle error if saving fails
            print("Error saving context: \(error.localizedDescription)")
        }
    }
}

