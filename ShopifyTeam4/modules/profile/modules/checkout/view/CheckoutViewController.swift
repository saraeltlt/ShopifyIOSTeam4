//
//  CheckoutViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 07/06/2023.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    @IBOutlet weak var noInternetConnectionView: UIView!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var shippinhFeesLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
  
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var couponTextField: UITextField!
    var viewModel : CheckoutViewModel!
    var discount = 0.0
    var shippingFees = 2
    var total = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureInternetConnectionObservation()
        if K.CURRENCY == "EGP"{
            subTotalLabel.text = "\(viewModel.subTotal) EGP"
            shippingFees = 65
            shippinhFeesLabel.text = "\(shippingFees) EGP"
            total = viewModel.subTotal+Double(shippingFees)
            totalLabel.text = "Total: \(total)EGP"
           
        }else{
            subTotalLabel.text = "\(viewModel.subTotal) USD"
            shippinhFeesLabel.text = "\(shippingFees) USD"
            total = viewModel.subTotal+Double(shippingFees)
            totalLabel.text = "Total: \(total)USD"
        }
    }
    
    func configureInternetConnectionObservation(){
        InternetConnectionObservation.getInstance.internetConnection.bind { status in
            guard let status = status else {return}
            if status {
                print("there is internet connection in category")
                DispatchQueue.main.async {
                    self.noInternetConnectionView.isHidden = true
                }
            }else {
                print("there is no internet connection in category")
                DispatchQueue.main.async {
                    self.noInternetConnectionView.isHidden = false
                }
            }
        }
    }
    
    
    
    
    
    @IBAction func validateCoupon(_ sender: UIButton) {
        switch couponTextField.text {
        case K.COUPONS.save15.rawValue:
            discount = 0.15 * viewModel.subTotal
            discountLabel.text = "\(discount)"
            
        case K.COUPONS.save50.rawValue:
            discount = 0.5 * viewModel.subTotal
            discountLabel.text = "\(discount)"
            
        case K.COUPONS.saveLimited80.rawValue:
            discount = 0.8 * viewModel.subTotal
            /*   if (discount>100){
             discount=100
             }*/
            discountLabel.text = "\(discount)"
            
        default:
            discountLabel.text = "NOT A VALID COUPON"
        }
       
        total = (viewModel.subTotal+Double(shippingFees)-discount)
        if K.CURRENCY == "EGP"{
       
            totalLabel.text = "Total:\(total) EGP"
        }else{
            totalLabel.text = "Total: \(total)USD"
        }
        
        
        
        
    }
        
        
        
    @IBAction func goToPayment(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
            let viewController = storyboard.instantiateViewController(identifier: "PaymentViewController") as! PaymentViewController
        viewController.viewModel  = viewModel.configNavigation(total : total)
            self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
