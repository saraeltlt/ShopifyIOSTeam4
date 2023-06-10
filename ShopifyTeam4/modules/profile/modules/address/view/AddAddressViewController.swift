//
//  AddAddressViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 06/06/2023.
//

import UIKit

class AddAddressViewController: UIViewController {
    @IBOutlet weak var streetText: UITextField!
    
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var countryText: UITextField!
    var delegate : AddAddress!
    override func viewDidLoad() {
        super.viewDidLoad()
 

    }
    
    @IBAction func addAddressBtn(_ sender: Any) {
        if isAnyTextFieldEmpty() {
           print("empty")
        } else {
            let phone = phoneText.text
            let sreet = streetText.text
            let city = cityText.text
            let country = countryText.text
            delegate.addAdress(address: "\(sreet!) - \(city!) - \(country!)", phoneNumber: phone!)
            self.dismiss(animated: true, completion: nil)
        }
      
  
    }
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    func isAnyTextFieldEmpty() -> Bool {
        let textFields: [UITextField] = [streetText, phoneText, cityText, countryText]

        for textField in textFields {
            if textField.text?.isEmpty ?? true {
                return true
            }
        }

        return false
    }
    
}
