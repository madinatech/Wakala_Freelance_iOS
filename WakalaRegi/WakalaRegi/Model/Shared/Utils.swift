
import UIKit
import Foundation

let ALERT_TITLE: String = ""

class Utils: NSObject {
    
    class func getTopViewController() -> UIViewController {
        var topController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        
        while ((topController?.presentedViewController) != nil) {
            topController = topController?.presentedViewController
        }
        
        return topController!
    }
    
    class func showAlert(withMessage message: String) {
        let alertController = UIAlertController(title: ALERT_TITLE, message: message , preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(actionOk)
        
        Utils.getTopViewController().present(alertController, animated: true)
    }
    
    class func isLeapYear(_ year: Int) -> Bool {
        let isLeapYear = ((year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0))
        return isLeapYear
    }
    
    class func showAlert(withTitle:String, withMessage: String, withButtonTitle:String) {
        let alertController = UIAlertController(title: withTitle, message: withMessage , preferredStyle: .alert)
        let actionOk = UIAlertAction(title: withButtonTitle, style: .default, handler: nil)
        alertController.addAction(actionOk)
        
        Utils.getTopViewController().present(alertController, animated: true)
    }
    
    class func isEmail(txt: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}", options: .caseInsensitive)
        return regex?.firstMatch(in: txt, options: [], range: NSMakeRange(0, txt.count)) != nil
    }
    
    class func isNumber(number:String) -> Bool{
        let numberRegEx = "[0-9]{10,13}"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        if numberTest.evaluate(with: number) == true {
            return true
        } else {
            return false
        }
    }
    
    class func isPhoneNumber(value: String) -> Bool {
        let PHONE_REGEX = "[0-9]{6,15}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    class func isZipcode(number:String) -> Bool{
        let numberRegEx = "[0-9]{1,10}"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        if numberTest.evaluate(with: number) == true {
            return true
        } else {
            return false
        }
    }
    
    class func isSimulator() -> Bool {
        return Platform.isSimulator
    }
    
    class func getDatetime(_ date : Date) -> String {
         let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a"
        return dateFormatter.string(from: date)
    }

    class func setBottomBorderForTextField(txtField: UITextField) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: txtField.frame.size.height - width, width:  txtField.frame.size.width, height: txtField.frame.size.height)
        border.borderWidth = width
        txtField.layer.addSublayer(border)
        txtField.layer.masksToBounds = true
    }
    
    class func setShadowForTextField(textField: UITextField) {
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = textField.bounds
        shadowLayer.shadowColor = UIColor(white: 0, alpha: 1).cgColor
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowLayer.shadowOpacity = 0.3
        shadowLayer.shadowRadius = 4
        shadowLayer.fillRule = CAShapeLayerFillRule.evenOdd
        let path: CGMutablePath = CGMutablePath()
        path.addRect(textField.bounds.insetBy(dx: -42, dy: -42), transform: .identity)
        let someInnerPath = (UIBezierPath(roundedRect: textField.bounds, cornerRadius: textField.layer.cornerRadius).cgPath)
        path.addPath(someInnerPath, transform: .identity)
        path.closeSubpath()
        shadowLayer.path = path
        textField.layer.addSublayer(shadowLayer)
        let maskLayer = CAShapeLayer()
        maskLayer.path = someInnerPath
        shadowLayer.mask = maskLayer
    }
    
    class func setShadowForTextView(textView: UITextView) {
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = textView.bounds
        shadowLayer.shadowColor = UIColor(white: 0, alpha: 1).cgColor
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowLayer.shadowOpacity = 0.1
        shadowLayer.shadowRadius = 4
        shadowLayer.fillRule = CAShapeLayerFillRule.evenOdd
        let path: CGMutablePath = CGMutablePath()
        path.addRect(textView.bounds.insetBy(dx: -15, dy: -15), transform: .identity)
        let someInnerPath = (UIBezierPath(roundedRect: textView.bounds, cornerRadius: textView.layer.cornerRadius).cgPath)
        path.addPath(someInnerPath, transform: .identity)
        path.closeSubpath()
        shadowLayer.path = path
        textView.layer.addSublayer(shadowLayer)
    }
    
    class func setShadowForView(inView: UIView) {
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = inView.bounds
        shadowLayer.shadowColor = UIColor(white: 0, alpha: 1).cgColor
        shadowLayer.shadowOffset = CGSize(width: 1, height:1)
        shadowLayer.shadowOpacity = 0.7
        shadowLayer.shadowRadius = 4
        shadowLayer.fillRule = CAShapeLayerFillRule.evenOdd
        let path: CGMutablePath = CGMutablePath()
        path.addRect(inView.bounds.insetBy(dx: -42, dy: -42), transform: .identity)
        let someInnerPath = (UIBezierPath(roundedRect: inView.bounds, cornerRadius: inView.layer.cornerRadius).cgPath)
        path.addPath(someInnerPath, transform: .identity)
        path.closeSubpath()
        shadowLayer.path = path
        inView.layer.addSublayer(shadowLayer)
        let maskLayer = CAShapeLayer()
        maskLayer.path = someInnerPath
        shadowLayer.mask = maskLayer
    }
    
    class func bottomInnerShadow(imageViewShadow: UIImageView) {
        let gradient = CAGradientLayer()
        gradient.frame = imageViewShadow.bounds
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.startPoint = CGPoint.init(x: 1, y: 1)
        gradient.endPoint = CGPoint.init(x: 1, y: 0.7)
        if gradient.superlayer == nil {
            imageViewShadow.layer.insertSublayer(gradient, at: 0)
        }
    }
    
    class func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newWidth))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newWidth))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    class func load_image(image_url_string:String, view:UIImageView) {
        let URL_IMAGE = URL(string: image_url_string )//"http://www.simplifiedtechy.net/wp-content/uploads/2017/07/simplified-techy-default.png"
        let session = URLSession(configuration: .default)
        
        //creating a dataTask
        let getImageFromUrl = session.dataTask(with: URL_IMAGE!) { (data, response, error) in
            
            //if there is any error
            if let e = error {
                //displaying the message
                print("Error Occurred: \(e)")
                
            } else {
                //in case of now error, checking wheather the response is nil or not
                if (response as? HTTPURLResponse) != nil {
                    
                    //checking if the response contains an image
                    if let imageData = data {
                        
                        //getting the image
                        let image = UIImage(data: imageData)
                        
                        //displaying the image
                        view.image = image
                        
                    } else {
                        print("Image file is currupted")
                    }
                } else {
                    print("No response from server")
                }
            }
        }
        getImageFromUrl.resume()
    }
    
    class func setBottomBorderForView(inView: UIView) {
        inView.layer.borderColor = UIColor.black.cgColor
        inView.layer.borderWidth = 1.0;
    }
    
    class func setBoolForKey(_ value: Bool, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func fetchBool(forKey key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    class func setStringForKey(_ value: String, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func fetchString(forKey key: String) -> String {
        return UserDefaults.standard.string(forKey: key)!
    }
    
    class func applyGradientForUIView(inView:UIView) {
        let layer = UIView(frame: CGRect(x: 0, y: 0, width: 376, height: 618))
        layer.alpha = 0.7
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: inView.frame.width, height: inView.frame.height)
        gradient.colors = [ UIColor(red:65/255, green:67/255, blue:63/255, alpha:1).cgColor, UIColor(red:126/255, green:134/255, blue:100/255, alpha:0.65).cgColor]
        //        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        layer.layer.addSublayer(gradient)
        inView.layer.addSublayer(gradient)
    }
}

extension String {
    func contains(_ find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    func containsIgnoringCase(_ find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

struct Platform {
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}

extension UIDevice {
    static var isIphoneX: Bool {
        var modelIdentifier = ""
        if isSimulator {
            modelIdentifier = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] ?? ""
        } else {
            var size = 0
            sysctlbyname("hw.machine", nil, &size, nil, 0)
            var machine = [CChar](repeating: 0, count: size)
            sysctlbyname("hw.machine", &machine, &size, nil, 0)
            modelIdentifier = String(cString: machine)
        }
        return modelIdentifier == "iPhone10,3" || modelIdentifier == "iPhone10,6"
    }
    
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}

