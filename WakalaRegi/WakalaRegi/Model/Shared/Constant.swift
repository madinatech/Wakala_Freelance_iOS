
import Foundation
import UIKit

typealias ItemLoadedBlock = (_ result: Any, _ error : String) -> (Void)

@available(iOS 10.0, *)

let appDelegateShared = UIApplication.shared.delegate as? AppDelegate

let appGreenColor = UIColor.init(red: 67.0/255.0, green: 155.0/255.0, blue: 59.0/255.0, alpha: 1.0)


let kDeviceToken                  = "kDeviceToken"
let kAlert_title                  = ""
let GoogleAutoCompleteAddressKey  = ""
let kLoginAutheticationHeader     = "LoginAutheticationHeader"





@IBDesignable public class RoundButton: UIButton {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        // layer.cornerRadius = 25.0
        // clipsToBounds = true
    }
}

@IBDesignable public class RoundView: UIView {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
        clipsToBounds = true
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        // layer.cornerRadius = 25.0
        // clipsToBounds = true
    }
}
@IBDesignable public class RoundImage: UIImageView {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        // layer.cornerRadius = 25.0
        // clipsToBounds = true
    }
}
@IBDesignable public class RoundButtonHome: UIButton {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = rounded ? 5 : 0
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        // layer.cornerRadius = 25.0
        // clipsToBounds = true
    }
}
