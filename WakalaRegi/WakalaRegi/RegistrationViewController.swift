

import UIKit
import ActionSheetPicker_3_0
import MagicalRecord
import NVActivityIndicatorView

class RegistrationViewController: UIViewController, NVActivityIndicatorViewable, UITextFieldDelegate,  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    
    @IBOutlet weak var txtbank: UITextField!
    @IBOutlet weak var txtBankaccoiunt: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    
    @IBOutlet weak var txtPin: UITextField!
    @IBOutlet weak var txtContactPerson: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var txtLoaction: UITextField!
    @IBOutlet weak var txtbeneficiaryName: UITextField!
    @IBOutlet weak var txtConfirmPin: UITextField!
    
    @IBOutlet weak var btnId: UIButton!
    @IBOutlet weak var btnTin: UIButton!
    @IBOutlet weak var btnLicence: UIButton!
    @IBOutlet weak var btnPermit: UIButton!
    @IBOutlet weak var btnAgreement: UIButton!
    
    @IBOutlet weak var imgId: UIImageView!
     @IBOutlet weak var imgTin: UIImageView!
     @IBOutlet weak var imgLicence: UIImageView!
     @IBOutlet weak var imgPermit: UIImageView!
     @IBOutlet weak var imgAgreement: UIImageView!
    
    var idImage = UIImage()
     var tinImage = UIImage()
     var licenceImage = UIImage()
    var permitImage = UIImage()
    var agreementImage = UIImage()
    
    var cityArray = [City]()
    var bankArray = [Bank]()
    var selectedBank = Bank()
    var selectedCity = City()
    var imagePicker = UIImagePickerController()
    var selectedButtonTag = Int()
    
    
    class func initViewController() -> RegistrationViewController {
        let vc = RegistrationViewController.init(nibName: "RegistrationViewController", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCityApi()
    }
    
    func loadCityApi (){
        Manager.sharedManager().loadCity { (response, errorMassage) -> (Void) in
            if(errorMassage.count > 0){
                Utils.showAlert(withMessage: errorMassage)
            } else{
                self.cityArray = City.getAll()
                self.loaBankApi()
            }
            
        }
    }
    func loaBankApi (){
        Manager.sharedManager().loadBank { (response, errorMassage) -> (Void) in
            if(errorMassage.count > 0){
                Utils.showAlert(withMessage: errorMassage)
            } else{
                self.bankArray = Bank.getAll()
            }
        }
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func uploadIDClicked(_ sender: UIButton) {
        selectedButtonTag = sender.tag
        uploadPhoto()
    }
    
    @IBAction func uploadTinClicked(_ sender: UIButton) {
          selectedButtonTag = sender.tag
        uploadPhoto()
    }
    
    @IBAction func uploadLicenceClicked(_ sender: UIButton) {
          selectedButtonTag = sender.tag
        uploadPhoto()
    }
    
    @IBAction func uploadPermitClikced(_ sender: UIButton) {
          selectedButtonTag = sender.tag
        uploadPhoto()
    }
    
    @IBAction func uploadAgreementClicked(_ sender: UIButton) {
          selectedButtonTag = sender.tag
        uploadPhoto()
    }
    
    func uploadPhoto ()  {
        let alert = UIAlertController(title: "Upload Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        } else{
            Utils.showAlert(withMessage: "You don't have camera")
        }
    }
    
    func openGallary() {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage]
        self.dismiss(animated: true) {
            if(self.selectedButtonTag == 100){
                self.btnId.isSelected = true
                self.idImage = image as! UIImage
                self.imgId.image = image as? UIImage
            } else if(self.selectedButtonTag == 200){
                self.btnTin.isSelected = true
                 self.tinImage = image as! UIImage
                self.imgTin.image = image as? UIImage
            }  else if(self.selectedButtonTag == 300){
                self.btnLicence.isSelected = true
                 self.licenceImage = image as! UIImage
                self.imgLicence.image = image as? UIImage
            } else if(self.selectedButtonTag == 400){
                self.btnPermit.isSelected = true
                 self.permitImage = image as! UIImage
                self.imgPermit.image = image as? UIImage
            } else if(self.selectedButtonTag == 500){
                self.btnAgreement.isSelected = true
                 self.agreementImage = image as! UIImage
                self.imgAgreement.image = image as? UIImage
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        var strMessage = ""
       
        
        if(txtName.text!.trimmingCharacters(in: .whitespaces).count <= 0){
            strMessage = "Please enter wakala name"
        } else if(txtMobileNumber.text!.trimmingCharacters(in: .whitespaces).count <= 0){
            strMessage = "Please enter mobile number"
        } else if(txtMobileNumber.text!.trimmingCharacters(in: .whitespaces).count < 12){
            strMessage = "Please enter valid mobile number"
        } else if(txtbank.text!.trimmingCharacters(in: .whitespaces).count <= 0){
            strMessage = "Please select bank"
        }else if(txtbeneficiaryName.text!.trimmingCharacters(in: .whitespaces).count <= 0){
            strMessage = "Please enter beneficiary Name"
        } else if(txtBankaccoiunt.text!.trimmingCharacters(in: .whitespaces).count <= 0){
            strMessage = "Please enter bank account number"
        } else if(txtContactPerson.text!.trimmingCharacters(in: .whitespaces).count <= 0){
            strMessage = "Please enter contact person"
        } else if(txtContactNumber.text!.trimmingCharacters(in: .whitespaces).count <= 0){
            strMessage = "Please enter conatct number"
        } else if(txtContactNumber.text!.trimmingCharacters(in: .whitespaces).count < 12){
            strMessage = "Please enter valid conatct number"
        } else if(txtCity.text!.trimmingCharacters(in: .whitespaces).count <= 0){
            strMessage = "Please select city"
        }  else if(txtLoaction.text!.trimmingCharacters(in: .whitespaces).count <= 0){
            strMessage = "Please enter street address"
        } else if(txtPin.text!.trimmingCharacters(in: .whitespaces).count <= 0){
            strMessage = "Please enter PIN"
        } else if(txtPin.text!.trimmingCharacters(in: .whitespaces).count < 4){
            strMessage = "Pin should be minimum 4 and maximum 8 digits"
        } else if(txtPin.text != txtConfirmPin.text){
            strMessage = "Pin and confirm pin is not matched"
        }
        
       if(txtEmail.text!.trimmingCharacters(in: .whitespaces).count > 0){
            if(!Utils.isEmail(txt: txtEmail.text ?? "")){
                strMessage = "Please enter valid email"
            }
        }
        
        if(strMessage.count > 0){
            Utils.showAlert(withMessage: strMessage)
            return
        }
        showProceedAlert()
        
    }
    
    func showProceedAlert ()  {
         var strMessage = String()
        if(txtEmail.text!.trimmingCharacters(in: .whitespaces).count > 0){
             strMessage = "Name: \(txtName.text ?? "")\nEmail: \(txtEmail.text ?? "")\nMobile number: \(txtMobileNumber.text ?? "")\nBank: \(txtbank.text ?? "")\nBank account number: \(txtBankaccoiunt.text ?? "")\nCity: \(txtCity.text ?? "")\nPIN: \(txtPin.text ?? "")\nContact Person: \(txtContactPerson.text ?? "")\nContact number: \(txtContactNumber.text ?? "")\nLocation: \(txtLoaction.text ?? "")\nBeneficiary name: \(txtbeneficiaryName.text ?? "")"
        } else{
             strMessage = "Name: \(txtName.text ?? "")\nMobile number: \(txtMobileNumber.text ?? "")\nBank: \(txtbank.text ?? "")\nBank account number: \(txtBankaccoiunt.text ?? "")\nCity: \(txtCity.text ?? "")\nPIN: \(txtPin.text ?? "")\nContact Person: \(txtContactPerson.text ?? "")\nContact number: \(txtContactNumber.text ?? "")\nLocation: \(txtLoaction.text ?? "")\nBeneficiary name: \(txtbeneficiaryName.text ?? "")"
        }
   
        
       
        let alert = UIAlertController(title: "Confirm", message:strMessage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Back", style: UIAlertAction.Style.default, handler: { _ in
        }))
        alert.addAction(UIAlertAction(title: "Continue",
                                      style: .default,
                                      handler: {(_: UIAlertAction!) in
                                       self.registerApiCall()
                                        
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func registerApiCall (){
         let wakala = WakalaList.mr_createEntity()!
        wakala.name = txtName.text
        wakala.email = txtEmail.text
        wakala.mobile_number = String((txtMobileNumber.text!).dropFirst()).replacingOccurrences(of: " ", with: "")
        wakala.bank_id = selectedBank.bank_id
        wakala.city = selectedCity.city_id
        wakala.bank_account_number = txtBankaccoiunt.text
        wakala.pin = txtPin.text
        wakala.contact_number = String((txtContactNumber.text!).dropFirst()).replacingOccurrences(of: " ", with: "")
        wakala.contact_person = txtContactPerson.text
        wakala.location = txtLoaction.text
        wakala.beneficiary_name = txtbeneficiaryName.text
        wakala.device_id =  UIDevice.current.identifierForVendor!.uuidString
        wakala.device_type = "ios"
        wakala.freelancer_id = AccountManager.instance().activeAccount?.freelancer_id
        if(btnId.isSelected == true){
            if let imageData = idImage.jpeg(.lowest) {
                wakala.idImage = imageData
            }
        }
        if(btnAgreement.isSelected == true){
//            let data = agreementImage.pngData() as NSData?
//            wakala.agreementImage = data as Data?
            
            if let imageData = agreementImage.jpeg(.lowest) {
                wakala.agreementImage = imageData
            }
        }
        if(btnPermit.isSelected == true){
//            let data = permitImage.pngData() as NSData?
//            wakala.permitImage = data as Data?
            if let imageData = permitImage.jpeg(.lowest) {
                wakala.permitImage = imageData
            }
        }
        if(btnLicence.isSelected == true){
//            let data = licenceImage.pngData() as NSData?
//            wakala.licenceImage = data as Data?
            
            if let imageData = licenceImage.jpeg(.lowest) {
                wakala.licenceImage = imageData
            }
        }
        if(btnTin.isSelected == true){
//            let data = tinImage.pngData() as NSData?
//            wakala.tinData = data as Data?
            
            if let imageData = tinImage.jpeg(.lowest) {
                wakala.tinData = imageData
            }
        }
        startAnimating()
        NVActivityIndicatorPresenter.sharedInstance.setMessage("")
        wakala.registerWakala { (response, errorMessage) -> (Void) in
             self.stopAnimating()
            wakala.mr_deleteEntity()
            if(errorMessage.count > 0){
                Utils.showAlert(withMessage: errorMessage)
            } else{
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func cityClicked(_ sender: Any) {
        var cityName = [String]()
        for city in cityArray{
            cityName.append(city.city_name ?? "")
        }
        
        ActionSheetStringPicker.show(withTitle: "Select City", rows: cityName, initialSelection: 0
            , doneBlock: { (picker, index, value) in
                self.txtCity.text = cityName[index]
                self.selectedCity = self.cityArray[index]
                self.view.layoutIfNeeded()
        }, cancel: { (picker) in
            
        }, origin: sender)
    }
    @IBAction func bankClciked(_ sender: Any) {
        var bankName = [String]()
        for bank in bankArray{
            bankName.append(bank.bank_name ?? "")
        }
        
        ActionSheetStringPicker.show(withTitle: "Select Bank", rows: bankName, initialSelection: 0
            , doneBlock: { (picker, index, value) in
                self.txtbank.text = bankName[index]
                self.selectedBank = self.bankArray[index]
                self.view.layoutIfNeeded()
        }, cancel: { (picker) in
            
        }, origin: sender)
    }
    
    func textField (_ textField :  UITextField, shouldChangeCharactersIn range:  NSRange, replacementString string:  String  )  ->  Bool {
        if textField ==  self.txtMobileNumber || textField == self.txtContactNumber {
            let textString = NSString(format:"%@",textField.text!)
            let  newString = textString.replacingCharacters(in: range, with: string) as NSString
            let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "") as NSString
            let length = components.length
            let hasLeadingOne = length > 0 && components.character(at: 0) == (1 as unichar)
            if length == 0 || (length > 10 && !hasLeadingOne) || length > 11 {
                let newLength = textString.length + (string as NSString).length - range.length as Int
                return (newLength > 9) ? false : true
            }
            var index = 0 as Int
            let formattedString = NSMutableString()
            if hasLeadingOne {
                formattedString.append("1 ")
                index += 1
            }
            if (length - index) > 4 {
                let areaCode = components.substring(with: NSMakeRange(index, 4))
                formattedString.appendFormat("%@ ", areaCode)
                index += 4
            }
            if length - index > 3 {
                let prefix = components.substring(with: NSMakeRange(index, 3))
                formattedString.appendFormat("%@ ", prefix)
                index += 3
            }
            if (textString.length) == 0 &&  newString != "0" {
                formattedString.appendFormat("0%@",textString)
                textField.text = formattedString as String
            }
            let remainder = components.substring(from: index)
            formattedString.append(remainder)
            textField.text = formattedString as String
            return false
        }
        if textField == txtPin {
            let maxLength = 6
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        if textField == txtConfirmPin {
            let maxLength = 6
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
    }
}


extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0.10
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}
