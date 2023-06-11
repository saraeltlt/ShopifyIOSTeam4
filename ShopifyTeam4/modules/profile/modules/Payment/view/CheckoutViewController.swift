//
//  CheckoutViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 07/06/2023.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var shippinhFeesLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var totalLabel: UIButton!
    @IBOutlet weak var couponTextField: UITextField!
    var subTotal = 0.0
    var discount = 0.0
    var shippingFees = 2
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if K.CURRENCY == "EGP"{
            subTotalLabel.text = "\(subTotal) EGP"
            shippingFees = 65
            shippinhFeesLabel.text = "\(shippingFees) EGP"
            totalLabel.subtitleLabel?.text = "Total: \(subTotal+Double(shippingFees))EGP"
           
        }else{
            subTotalLabel.text = "\(subTotal) USD"
            shippinhFeesLabel.text = "\(shippingFees) USD"
            totalLabel.subtitleLabel?.text = "Total: \(subTotal+Double(shippingFees))USD"
        }
    }
    
    @IBAction func validateCoupon(_ sender: UIButton) {
        switch couponTextField.text {
        case K.COUPONS.save15.rawValue:
            discount = 0.15 * subTotal
            discountLabel.text = "\(discount)"
            
        case K.COUPONS.save50.rawValue:
            discount = 0.5 * subTotal
            discountLabel.text = "\(discount)"
            
        case K.COUPONS.saveLimited80.rawValue:
            discount = 0.8 * subTotal
            /*   if (discount>100){
             discount=100
             }*/
            discountLabel.text = "\(discount)"
            
        default:
            discountLabel.text = "NOT A VALID COUPON"
        }
        
        if K.CURRENCY == "EGP"{
            totalLabel.subtitleLabel?.text = "Total: \(subTotal+Double(shippingFees)-discount)EGP"
        }else{
            totalLabel.subtitleLabel?.text = "Total: \(subTotal+Double(shippingFees)-discount)USD"
        }
        
        
        
        
    }
        
        
        
    @IBAction func placeOrderBtn(_ sender: UIButton) {
    }
    
}
