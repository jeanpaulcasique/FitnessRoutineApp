
import Foundation
import CoreData

@objc(Rutina)
public class Rutina: NSManagedObject {

}
extension Rutina {
    var exercisesArray: [Ejercicio] {
        let set = exercises as? Set<Ejercicio> ?? []
        return set.sorted {
            $0.name ?? "" < $1.name ?? ""
        }
    }
}
