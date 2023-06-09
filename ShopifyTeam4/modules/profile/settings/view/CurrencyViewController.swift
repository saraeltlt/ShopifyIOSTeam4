//
//  CurrencyViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 06/06/2023.
//

import UIKit

class CurrencyViewController: UIViewController {
    var delegate: UpdateData!
    var btnHandler : (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func USDBtn(_ sender: UIButton) {
        UserDefaults.selectedCurrency = "USD"
        K.CURRENCY = "USD"
        delegate.reloadTable()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func EGYBtn(_ sender: UIButton) {
        UserDefaults.selectedCurrency = "EGP"
        K.CURRENCY = "EGP"
        delegate.reloadTable()
        self.dismiss(animated: true, completion: nil)
        
    }
}
