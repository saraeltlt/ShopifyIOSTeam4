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
    @IBOutlet weak var countryTextField: DropDown!{
        didSet{
            self.countryTextField.optionArray = K.generateCountries()
            self.countryTextField.selectedRowColor = UIColor(named: K.LIGHT_ORANGE)!
        }
    }
    var delegate : AddAddress!
    var viewModel = AddAddressViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
 

    }
    
    @IBAction func addAddressBtn(_ sender: Any) {
        if isAnyTextFieldEmpty() {
            self.view.makeToast("Complete the empty fields", duration: 2 ,title: "Empty fields" ,image: UIImage(named: K.WARNINNG_IMAGE))
        } else {
            let phone = phoneText.text!
            let street = streetText.text!
            let city = cityText.text!
            let country = countryTextField.text!
            if (!viewModel.isValidPhoneNumber(phone)){
                self.view.makeToast("Enter a valid phone number", duration: 2 ,title: "ERROR" ,image: UIImage(named: K.WARNINNG_IMAGE))
            }
            else{
            viewModel.addAddress(phone: phone, street: street, city: city, country: country)
            viewModel.addAddressObservable.bind { msg in
                DispatchQueue.main.async {
                    if msg == "success"{
                        
                        self.delegate.addAdress(address: self.viewModel.newAddress!)
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                    else if msg == "error"{
                        self.view.makeToast("Not a valid country", duration: 2 ,title: "ERROR!" ,image: UIImage(named: K.WARNINNG_IMAGE))
                    }
                }
                
            }
        }

        }
      
  
    }
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    func isAnyTextFieldEmpty() -> Bool {
        let textFields: [UITextField] = [streetText, phoneText, cityText, countryTextField]

        for textField in textFields {
            if textField.text?.isEmpty ?? true {
                return true
            }
        }

        return false
    }
    
}
