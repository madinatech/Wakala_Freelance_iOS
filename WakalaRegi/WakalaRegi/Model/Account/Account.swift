
import UIKit

typealias AccountBlock = (_ success : Bool, _ request: Account, _ errorMessage: String) -> (Void)
class Account: NSObject ,NSCoding {
    var accountBlock: AccountBlock  = {_,_,_ in }
    
    var mobileNumber : String = ""
    var city_id : String = ""
    var bank_id : String = ""
    var pin : String = ""
    var name : String = ""
    var password : String = ""
    var deviceID : String = ""
    var contact_person : String = ""
    var contact_number : String = ""
    var location : String = ""
    var beneficiary_name : String = ""
    var bank_account_number : String = ""
    var email : String = ""
    var buisness_code : String = ""
    var role_id : Int = 0
    var activation_key : String = ""
    var reference_number : String = ""
    var bank_name : String = ""
    var bank_ifsc : String = ""
    var wakala_id : String = ""
    var image_before_url : String = ""
    var freelancer_id : String = ""
    
    let ENCODING_VERSION:Int = 1
    
    override init() {}
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(ENCODING_VERSION, forKey: "version")
        aCoder.encode(mobileNumber, forKey: "mobileNumber")
        aCoder.encode(deviceID, forKey: "deviceID");
        aCoder.encode(email, forKey: "email");
        aCoder.encode(wakala_id, forKey: "wakala_id");
        aCoder.encode(reference_number, forKey: "reference_number");
        aCoder.encode(contact_person, forKey: "contact_person");
        aCoder.encode(contact_number, forKey: "contact_number");
        aCoder.encode(bank_id, forKey: "bank_id");
        aCoder.encode(beneficiary_name, forKey: "beneficiary_name");
        aCoder.encode(bank_account_number, forKey: "bank_account_number");
        aCoder.encode(bank_name, forKey: "bank_name");
        aCoder.encode(bank_ifsc, forKey: "bank_ifsc");
         aCoder.encode(freelancer_id, forKey: "freelancer_id");
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        if(aDecoder.decodeInteger(forKey: "version") == ENCODING_VERSION) {
            mobileNumber = aDecoder.decodeObject(forKey: "mobileNumber") as! String
            deviceID = aDecoder.decodeObject(forKey: "deviceID") as! String;
            email = aDecoder.decodeObject(forKey: "email") as! String;
            wakala_id = aDecoder.decodeObject(forKey: "wakala_id") as! String;
            reference_number = aDecoder.decodeObject(forKey: "reference_number") as! String;
            contact_person = aDecoder.decodeObject(forKey: "contact_person") as! String;
            contact_number = aDecoder.decodeObject(forKey: "contact_number") as! String;
            bank_id = aDecoder.decodeObject(forKey: "bank_id") as! String;
            beneficiary_name = aDecoder.decodeObject(forKey: "beneficiary_name") as! String;
            bank_account_number = aDecoder.decodeObject(forKey: "bank_account_number") as! String;
            bank_name = aDecoder.decodeObject(forKey: "bank_name") as! String;
            bank_ifsc = aDecoder.decodeObject(forKey: "bank_ifsc") as! String;
            freelancer_id = aDecoder.decodeObject(forKey: "freelancer_id") as! String;
        }
    }
    
    func parseUserDict(userDict:NSDictionary) {
        
        if let str = userDict.value(forKey: "mobile_number") as? String{
            self.mobileNumber = str
        }
        if let str = userDict.value(forKey: "freelancer_id") as? String{
            self.freelancer_id = str
        }
    
        if let str = userDict.value(forKey: "email") as? String{
            self.email = str
        }
        if let str = userDict.value(forKey: "wakala_id") as? String{
            self.wakala_id = str
        }
        
        if let str = userDict.value(forKey: "reference_number") as? String{
            self.reference_number = str
        }
        if let str = userDict.value(forKey: "contact_person") as? String{
            self.contact_person = str
        }
        if let str = userDict.value(forKey: "contact_number") as? String{
            self.contact_number = str
        }
      
        if let str = userDict.value(forKey: "bank_id") as? String{
            self.bank_id = str
        }
        if let str = userDict.value(forKey: "beneficiary_name") as? String{
            self.beneficiary_name = str
        }
        if let str = userDict.value(forKey: "bank_account_number") as? String{
            self.bank_account_number = str
        }
        if let str = userDict.value(forKey: "bank_name") as? String{
            self.bank_name = str
        }
        if let str = userDict.value(forKey: "bank_ifsc") as? String{
            self.bank_ifsc = str
        }
       
    }
    
    func login(block: @escaping AccountBlock)  {
        accountBlock = block
        let request = Request.init(url: "\(kBaseUrl)\(kLogin)", method: RequestMethod(rawValue: "POST")!) { (success:Bool, request:Request, message:NSString) -> (Void) in
            if(request.isSuccess){
                let serverDict = request.serverData as NSDictionary
                if (serverDict.value(forKey: "data") != nil) {
                    let dataArray : [[String : Any]] = serverDict.value(forKey: "data") as! [[String : Any]]
                    if(dataArray.count > 0){
                        self.parseUserDict(userDict: dataArray[0] as NSDictionary)
                    }
                }
                self.accountBlock(true,self,"")
            } else {
                self.accountBlock(false,self,message as String)
            }
        }
        
        request.setParameter(mobileNumber, forKey: "mobile_number")
        request.setParameter(password, forKey: "passcode")
        request.setParameter(deviceID, forKey: "device_id")//fdssdgdfgdfgdfg
        request.setParameter("ios", forKey: "device_type")//android
        request.startRequest()
    }
}
