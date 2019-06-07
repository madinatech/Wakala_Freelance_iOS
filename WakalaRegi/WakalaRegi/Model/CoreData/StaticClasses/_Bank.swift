// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Bank.swift instead.

import Foundation
import CoreData

public enum BankAttributes: String {
    case bank_display_name = "bank_display_name"
    case bank_id = "bank_id"
    case bank_name = "bank_name"
}

open class _Bank: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Bank"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<Bank> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Bank.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var bank_display_name: String?

    @NSManaged open
    var bank_id: String?

    @NSManaged open
    var bank_name: String?

    // MARK: - Relationships

}

