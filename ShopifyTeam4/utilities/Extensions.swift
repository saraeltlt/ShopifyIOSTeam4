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
    
   /* func showNoInternetAlert() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myAlert = storyboard.instantiateViewController(withIdentifier: "CustomAlertViewController") as! CustomAlertViewController
        myAlert.titles="No internet connection"
        myAlert.subTitle="Please check your wifi or celluar data and try again"
        myAlert.imageName=K.WIFI_Alert_IMAGE
        myAlert.okBtn="OK"
        
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func confirmDeleteAlert(handler: (() -> Void)?) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myAlert = storyboard.instantiateViewController(withIdentifier: "CustomAlertViewController") as! CustomAlertViewController
        
        myAlert.titles="Delete Favorite"
        myAlert.subTitle="Are you sure you want to delete this team from favorites?"
        myAlert.imageName=K.DELETE_ALERT_IMAGE
        myAlert.okBtn="Yes, Delete"
        myAlert.okBtnHandler=handler
        myAlert.cancelBtn="Cancel"
        
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(myAlert, animated: true, completion: nil)
    }*/
    

    
}
