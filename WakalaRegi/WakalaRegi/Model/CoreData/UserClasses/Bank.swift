import Foundation
import FastEasyMapping
import MagicalRecord

@objc(Bank)
open class Bank: _Bank {
    
    class func defaultMapping() -> FEMMapping {
        let mapping = FEMMapping(entityName: Bank.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: Bank.self) as! [String : String]
        mapping.addAttributes(from: dict)
        mapping.primaryKey = "bank_id"
        
        return mapping
    }
    
    class func getAll() -> [Bank] {
        let arr = Bank.mr_findAllSorted(by: "bank_name", ascending: true)
        return arr as! [Bank]
    }
}
