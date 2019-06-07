// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to WakalaList.swift instead.

import Foundation
import CoreData

public enum WakalaListAttributes: String {
    case activation_key = "activation_key"
    case agreementImage = "agreementImage"
    case bank_account_number = "bank_account_number"
    case bank_id = "bank_id"
    case bank_ifsc = "bank_ifsc"
    case bank_name = "bank_name"
    case beneficiary_name = "beneficiary_name"
    case buisness_code = "buisness_code"
    case city = "city"
    case contact_number = "contact_number"
    case contact_person = "contact_person"
    case created = "created"
    case device_id = "device_id"
    case device_type = "device_type"
    case email = "email"
    case freelancer_id = "freelancer_id"
    case idImage = "idImage"
    case image_before_url = "image_before_url"
    case licenceImage = "licenceImage"
    case location = "location"
    case mobile_number = "mobile_number"
    case modified = "modified"
    case name = "name"
    case permitImage = "permitImage"
    case pin = "pin"
    case reference_number = "reference_number"
    case role_id = "role_id"
    case status = "status"
    case tinData = "tinData"
    case wakala_id = "wakala_id"
}

open class _WakalaList: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "WakalaList"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<WakalaList> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _WakalaList.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var activation_key: String?

    @NSManaged open
    var agreementImage: Data?

    @NSManaged open
    var bank_account_number: String?

    @NSManaged open
    var bank_id: String?

    @NSManaged open
    var bank_ifsc: String?

    @NSManaged open
    var bank_name: String?

    @NSManaged open
    var beneficiary_name: String?

    @NSManaged open
    var buisness_code: String?

    @NSManaged open
    var city: String?

    @NSManaged open
    var contact_number: String?

    @NSManaged open
    var contact_person: String?

    @NSManaged open
    var created: String?

    @NSManaged open
    var device_id: String?

    @NSManaged open
    var device_type: String?

    @NSManaged open
    var email: String?

    @NSManaged open
    var freelancer_id: String?

    @NSManaged open
    var idImage: Data?

    @NSManaged open
    var image_before_url: String?

    @NSManaged open
    var licenceImage: Data?

    @NSManaged open
    var location: String?

    @NSManaged open
    var mobile_number: String?

    @NSManaged open
    var modified: String?

    @NSManaged open
    var name: String?

    @NSManaged open
    var permitImage: Data?

    @NSManaged open
    var pin: String?

    @NSManaged open
    var reference_number: String?

    @NSManaged open
    var role_id: Int32 // Optional scalars not supported

    @NSManaged open
    var status: Int32 // Optional scalars not supported

    @NSManaged open
    var tinData: Data?

    @NSManaged open
    var wakala_id: String?

    // MARK: - Relationships

}

