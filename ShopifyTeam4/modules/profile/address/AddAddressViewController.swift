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
    override func viewDidLoad() {
        super.viewDidLoad()
 

    }
    
    @IBAction func addAddressBtn(_ sender: Any) {
        
        let phone = phoneText.text
        let sreet = streetText.text
        let city = cityText.text
        let country = countryText.text
        self.dismiss(animated: true, completion: nil)

        
        
    }
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
}
