

import Foundation
import CoreData


extension Ejercicio {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ejercicio> {
        return NSFetchRequest<Ejercicio>(entityName: "Ejercicio")
    }

    @NSManaged public var name: String?
    @NSManaged public var duration: Int16
    @NSManaged public var repetitions: Int16
    @NSManaged public var routine: Rutina?

}

extension Ejercicio : Identifiable {

}
