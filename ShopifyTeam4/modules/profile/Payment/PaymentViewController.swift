//
//  PaymentViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 07/06/2023.
//

import UIKit

class PaymentViewController: UIViewController {

    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var cashBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func payCash(_ sender: UIButton) {
        onlineBtn.setImage(UIImage(systemName: "circle"), for: .normal)
        cashBtn.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        
    }
    
    @IBAction func payOnline(_ sender: UIButton) {
        onlineBtn.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        cashBtn.setImage(UIImage(systemName: "circle"), for: .normal)
    }
}
