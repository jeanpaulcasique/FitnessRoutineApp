
import Foundation
import CoreData


extension Rutina {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Rutina> {
        return NSFetchRequest<Rutina>(entityName: "Rutina")
    }

    @NSManaged public var name: String?
    @NSManaged public var createdDate: Date?
    @NSManaged public var exercises: NSSet?

}

// MARK: Generated accessors for exercises
extension Rutina {

    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: Ejercicio)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: Ejercicio)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSSet)

}

extension Rutina : Identifiable {

}
