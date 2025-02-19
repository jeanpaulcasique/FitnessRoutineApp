import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {

}
extension User {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    @NSManaged public var gender: String?
    @NSManaged public var goal: String?
    @NSManaged public var currentBodyShape: String?
    @NSManaged public var desiredBodyShape: String?
    @NSManaged public var birthYear: Int16
    @NSManaged public var height: Double
}

