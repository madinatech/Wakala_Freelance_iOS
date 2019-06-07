

import UIKit
import NVActivityIndicatorView

class LoginViewController: UIViewController , NVActivityIndicatorViewable, UITextFieldDelegate{
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    
    
    class func initViewController() -> LoginViewController {
        let vc = LoginViewController.init(nibName: "LoginViewController", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtUsername.becomeFirstResponder()
//        txtUsername.text = "0123123123"
//        txtPassword.text = "123456"
        
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        var strMessage = ""
        let strNumber = txtUsername.text!.trimmingCharacters(in: .whitespaces)
        let strPasscode = txtPassword.text!.trimmingCharacters(in: .whitespaces)
        
        if(strNumber.count <= 0){
            strMessage = "Please enter mobile number"
        } else if(strPasscode.count <= 0){
            strMessage = "Please enter password"
        }
        
        if(strMessage.count > 0){
            Utils.showAlert(withMessage: strMessage)
            return
        }
        loginApicall()
    }
    
    func loginApicall ()  {
        startAnimating()
        NVActivityIndicatorPresenter.sharedInstance.setMessage("")
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        let account = Account()
        account.mobileNumber = String((txtUsername.text!).dropFirst()).replacingOccurrences(of: " ", with: "")
        account.password = txtPassword.text!
        account.deviceID = deviceID
        account.login { (isSuccess, account, errorMessage) -> (Void) in
            self.stopAnimating()
            if errorMessage.count > 0{
                Utils.showAlert(withMessage: errorMessage)
                return
            }
            AccountManager.instance().activeAccount = account
            AppDelegate.appDelegateShared().userDidLogin()
        }
    }
    
    func textField (_ textField :  UITextField, shouldChangeCharactersIn range:  NSRange, replacementString string:  String  )  ->  Bool {
        if textField ==  self.txtUsername {
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
        if textField == txtPassword {
            let maxLength = 8
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
    }
    
    
}
