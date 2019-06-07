import Foundation
import FastEasyMapping
import MagicalRecord


@objc(City)
open class City: _City {

    class func defaultMapping() -> FEMMapping {
        let mapping = FEMMapping(entityName: City.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: City.self) as! [String : String]
        mapping.addAttributes(from: dict)
        mapping.primaryKey = "city_id"
        
        return mapping
    }
    
    class func getAll() -> [City] {
        let arr = City.mr_findAllSorted(by: "city_name", ascending: true)
        return arr as! [City]
    }
    
    class func getById(_ cityID: String) -> City {
        let pre = NSPredicate(format: "city_id == %@", cityID)
        
        if let aCity = City.mr_findFirst(with: pre) {
            return aCity
        }
        
        let bCity = City.mr_createEntity()
        
        return bCity!
    }
    
  
    
   
    
   
}
