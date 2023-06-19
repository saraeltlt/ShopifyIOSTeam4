//
//  Extensions.swift
//  Shopify_team4
//
//  Created by Sara Eltlt on 03/06/2023.
//

import UIKit

//MARK: - change mood
extension AppDelegate {
   func overrideApplicationThemeStyle() {
        if #available(iOS 13.0, *) {
            let isDarkMode = UserDefaults.standard.bool(forKey: K.APPERANCE_MODE_KEY)
            let appearanceMode: UIUserInterfaceStyle = isDarkMode ? .dark : .light
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = appearanceMode
        } else {
            let isDarkMode = UserDefaults.standard.bool(forKey: K.APPERANCE_MODE_KEY)
            UIApplication.shared.statusBarStyle = isDarkMode ? .lightContent : .default
        }
    }
}
//MARK: - settings user defaults
extension UserDefaults {
    private static let currencyKey = "SelectedCurrency"

    static var selectedCurrency: String? {
        get {
            return UserDefaults.standard.string(forKey: currencyKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: currencyKey)
        }
    }
    
    
    private static let userID = "SelectedUserID"

    static var selectedUserID: Int? {
        get {
            return UserDefaults.standard.integer(forKey: userID)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: userID)
        }
    }
    
    private static let favID = "favID"

    static var selectedFavID: Int? {
        get {
            return UserDefaults.standard.integer(forKey: favID)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: favID)
        }
    }
    
    private static let cartID = "cartID"

    static var selectedCartID: Int? {
        get {
            return UserDefaults.standard.integer(forKey: cartID)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: cartID)
        }
    }
    
    
    
    
    
    
    private static let addressKey = "DefaultAddress"

    static var DefaultAddress: String? {
        get {
            return UserDefaults.standard.string(forKey: addressKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: addressKey)
        }
    }
}
//MARK: - gradient Background
extension UIView {
    func addGradient(with layer: CAGradientLayer, gradientFrame: CGRect? = nil, colorSet: [UIColor],
                     locations: [Double], startEndPoints: (CGPoint, CGPoint)? = nil) {
        layer.frame = gradientFrame ?? self.bounds
        layer.frame.origin = .zero
        
        let layerColorSet = colorSet.map { $0.cgColor }
        let layerLocations = locations.map { $0 as NSNumber }
        
        layer.colors = layerColorSet
        layer.locations = layerLocations
        
        if let startEndPoints = startEndPoints {
            layer.startPoint = startEndPoints.0
            layer.endPoint = startEndPoints.1
        }
        
        self.layer.insertSublayer(layer, above: self.layer)
    }
}

//MARK: - Custom alerts
extension UIViewController {
    func confirmAlert(title:String = "Delete" , subTitle:String = "Are you sure you want to delete this Item?" , imageName:String = K.WARNINNG_IMAGE, confirmBtn: String = "Yes, Delete" ,handler: (() -> Void)?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myAlert = storyboard.instantiateViewController(withIdentifier: "CustomAlertViewController") as! CustomAlertViewController
        
        myAlert.titles = title
        myAlert.subTitle = subTitle
        myAlert.imageName = imageName
        myAlert.okBtn = confirmBtn
        myAlert.okBtnHandler = handler
        myAlert.cancelBtn = "Cancel"
        
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(myAlert, animated: true, completion: nil)
    }
    func GuestMoodAlert(){
            self.confirmAlert(title: "Guest Mood",subTitle: "can't access this feature in guest mood, do you want to login/register?", imageName: K.GUEST_IMAGE, confirmBtn: "Yes,Login/Register") {
                K.GUEST_MOOD=false
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                  let viewController = storyboard.instantiateViewController(identifier: "OptionsViewController") as OptionsViewController
                viewController.modalPresentationStyle = .fullScreen
                  viewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                  self.present(viewController, animated: false, completion: nil)
            }
        
    }
    func errorTitledAlert(title:String = "Error" , subTitle:String , imageName:String = K.WARNINNG_IMAGE, confirmBtn: String = "Ok" ,handler: (() -> Void)? = {}) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myAlert = storyboard.instantiateViewController(withIdentifier: "CustomAlertViewControllerOneButton") as! CustomAlertViewControllerOneButton
        
        myAlert.titles = title
        myAlert.subTitle = subTitle
        myAlert.imageName = imageName
        myAlert.okBtn = confirmBtn
        myAlert.okBtnHandler = handler
        
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(myAlert, animated: true, completion: nil)
    }
    func notTitledCustomAlert(title:String , subTitle:String , imageName:String = K.WARNINNG_IMAGE, confirmBtn: String = "Ok" ,handler: (() -> Void)?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myAlert = storyboard.instantiateViewController(withIdentifier: "CustomAlertViewControllerOneButton") as! CustomAlertViewControllerOneButton
        
        myAlert.titles = title
        myAlert.subTitle = subTitle
        myAlert.imageName = imageName
        myAlert.okBtn = confirmBtn
        myAlert.okBtnHandler = handler
        
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(myAlert, animated: true, completion: nil)
    }
    
}

//MARK: - Custom String date
extension String {
    func cutStringIntoComponents() -> (date: String ,year: String, month: String, day: String, time: String)? {
        let components = self.components(separatedBy: "T")
        if components.count >= 2 {
            let dateString = components[0] // "2023-06-15"
            let timeString = components[1] // "14:23:54-04:00"
            let dateComponents = dateString.components(separatedBy: "-")
            if dateComponents.count == 3 {
                let year = dateComponents[0]
                let month = dateComponents[1]
                let day = dateComponents[2]
                let timeComponents = timeString.components(separatedBy: "-")
                let time = timeComponents[0]
                return (dateString,year, month, day, time)
            }
        }
        
        return nil // Invalid string format
    }

}

//MARK: - Custom String date
extension UIView {
    private static let badgeTag = 999

    func addBadge(text: String,color:String) {
        let badgeLabel = UILabel()
        badgeLabel.tag = UIButton.badgeTag
        badgeLabel.textAlignment = .center
        badgeLabel.textColor = .white
        badgeLabel.backgroundColor = UIColor(named: color)
        badgeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        badgeLabel.layer.cornerRadius = 8
        badgeLabel.clipsToBounds = true

        badgeLabel.text = text
        badgeLabel.sizeToFit()
        let badgeSize = CGSize(width: badgeLabel.frame.size.width + 8, height: 16)
        badgeLabel.frame = CGRect(origin: .zero, size: badgeSize)

        let badgeX = self.frame.size.width - badgeLabel.frame.size.width - 4
        let badgeY = (self.frame.size.height - badgeLabel.frame.size.height) / 6
        badgeLabel.frame.origin = CGPoint(x: badgeX, y: badgeY)

        badgeLabel.layer.zPosition = 1
        self.addSubview(badgeLabel)
    }

    func removeBadge() {
        self.subviews.filter { $0.tag == UIButton.badgeTag }.forEach { $0.removeFromSuperview() }
    }
}

