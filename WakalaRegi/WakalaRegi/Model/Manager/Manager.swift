
import UIKit
import FastEasyMapping
import MagicalRecord
class Manager: NSObject {
    var itemLoadedBlock : ItemLoadedBlock = {_,_ in }
    
    class func sharedManager() -> Manager {
        var singleton: Manager? = nil
        if singleton == nil {
            singleton = Manager()
        }
        return singleton!
    }
    
    func loadCity(block : @escaping ItemLoadedBlock) {
        itemLoadedBlock = block
        let request = Request.init(url: "\(kBaseUrl)\(kGetCity)", method: RequestMethod(rawValue: "GET")!) { (success:Bool, request:Request, errorMessage:NSString) -> (Void) in
            if(request.isSuccess){
                MagicalRecord.save({ (localContext: NSManagedObjectContext) in
                                        let dataArray = request.serverData["data"] as! [[String : Any]]
                                        let arr = FEMDeserializer.collection(fromRepresentation: dataArray, mapping: City.defaultMapping(), context: localContext)
                                        print(arr)
                                    }, completion: { (isSuccess, error) in
                                        self.itemLoadedBlock([],"")
                                    })
                
            } else {
                self.itemLoadedBlock("",errorMessage as String)
            }
        }
        request.startRequest()
    }
    
    func loadBank(block : @escaping ItemLoadedBlock) {
        itemLoadedBlock = block
        let request = Request.init(url: "\(kBaseUrl)\(kGetBank)", method: RequestMethod(rawValue: "GET")!) { (success:Bool, request:Request, errorMessage:NSString) -> (Void) in
            if(request.isSuccess){
                MagicalRecord.save({ (localContext: NSManagedObjectContext) in
                    let dataArray = request.serverData["data"] as! [[String : Any]]
                    let arr = FEMDeserializer.collection(fromRepresentation: dataArray, mapping: Bank.defaultMapping(), context: localContext)
                    print(arr)
                }, completion: { (isSuccess, error) in
                    self.itemLoadedBlock([],"")
                })
                
            } else {
                self.itemLoadedBlock("",errorMessage as String)
            }
        }
        request.startRequest()
    }
    
    
   

}
