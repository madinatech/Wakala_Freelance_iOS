import Foundation
import FastEasyMapping
import MagicalRecord

@objc(WakalaList)
open class WakalaList: _WakalaList {
    var itemLoadedBlock : ItemLoadedBlock = {_,_ in }
    
    class func sharedManager() -> Manager {
        var singleton: Manager? = nil
        if singleton == nil {
            singleton = Manager()
        }
        return singleton!
    }
    
    class func defaultMapping() -> FEMMapping {
        let mapping = FEMMapping(entityName: WakalaList.entityName())
        let dict: [String: String] = CDHelper.mapping(cls: WakalaList.self) as! [String : String]
        //        dict.removeValue(forKey: "create_date")
        //        dict.removeValue(forKey: "last_updated")
        //        dict.removeValue(forKey: "start_time")
        //        dict.removeValue(forKey: "end_time")
        mapping.addAttributes(from: dict)
        
        //        mapping.addAttribute(Appointments.dateTimeAttribute(for: "start_time", andKeyPath: "start_time"))
        //        mapping.addAttribute(Appointments.dateTimeAttribute(for: "end_time", andKeyPath: "end_time"))
        //        mapping.addAttribute(Appointments.dateTimeAttribute(for: "last_updated", andKeyPath: "last_updated"))
        //        mapping.addAttribute(Appointments.dateTimeAttribute(for: "create_date", andKeyPath: "create_date"))
        //        mapping.addRelationshipMapping(Doctor.defaultMapping(), forProperty: "doctor", keyPath: "doctor")
        //        mapping.addRelationshipMapping(Patient.defaultMapping(), forProperty: "patient", keyPath: "patient")
        mapping.primaryKey = "wakala_id"
        
        return mapping
    }
    
    class func getAll() -> [WakalaList] {
        let arr = WakalaList.mr_findAllSorted(by: "wakala_id", ascending: false)
        return arr as! [WakalaList]
    }
    func saveEntity() {
        NSManagedObjectContext.mr_default().mr_saveToPersistentStore { (contectDidSave, error) in
            if(contectDidSave){
            }else{
            }
        }
    }
    
    func registerWakala(block : @escaping ItemLoadedBlock) {
        itemLoadedBlock = block
        let request = Request.init(url: "\(kBaseUrl)\(kRegister)", method: RequestMethod(rawValue: "MULTI_PART_FORM")!) { (success:Bool, request:Request, errorMessage:NSString) -> (Void) in
            if(request.isSuccess){
                MagicalRecord.save({ (localContext: NSManagedObjectContext) in
                    let dataArray = request.serverData["data"] as! [[String : Any]]
                    if(dataArray.count > 0){
                        let dataDict = dataArray[0]
                        _ =  FEMDeserializer.object(fromRepresentation: dataDict, mapping: WakalaList.defaultMapping(), context: localContext)
                    } else {
                          self.itemLoadedBlock([],"")
                    }
                }, completion: { (isSuccess, error) in
                    self.itemLoadedBlock([],"")
                })

            } else {
                self.itemLoadedBlock("",errorMessage as String)
            }
        }
        
        request.setParameter(mobile_number ?? "", forKey: "mobile_number")
        request.setParameter(city ?? "", forKey: "city_id")
        request.setParameter(bank_id ?? "", forKey: "bank_id")
        request.setParameter(pin ?? "", forKey: "pin")
        request.setParameter(name ?? "", forKey: "name")
        request.setParameter(device_id ?? "", forKey: "device_id")
        request.setParameter(device_type ?? "", forKey: "device_type")
        request.setParameter(contact_person ?? "", forKey: "contact_person")
        request.setParameter(contact_number ?? "", forKey: "contact_number")
        request.setParameter(location ?? "", forKey: "location")
        request.setParameter(beneficiary_name ?? "", forKey: "beneficiary_name")
        request.setParameter(bank_account_number ?? "", forKey: "bank_account_number")
        request.setParameter(email ?? "", forKey: "email")
        if(idImage != nil){
            request.idImageData = idImage!
            request.isIdImageData = true
        }
        if(tinData != nil){
            request.tinImageData = tinData!
             request.isTinImageData = true
        }
        if(licenceImage != nil){
            request.licenceImageData = licenceImage!
             request.isLicenceImageData = true
        }
        if(permitImage != nil){
             request.permitImageData = permitImage!
             request.isPermitImageData = true
        }
        if(agreementImage != nil){
             request.agreementImageData = agreementImage!
             request.isAgreementImageData = true
        }
        request.startRequest()
    }
}
