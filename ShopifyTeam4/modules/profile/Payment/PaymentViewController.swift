//
//  PaymentViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 07/06/2023.
//

import UIKit
import PassKit

class PaymentViewController: UIViewController {

    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var cashBtn: UIButton!
    
    private var paymentRequest : PKPaymentRequest = {
      let request = PKPaymentRequest()
        request.merchantIdentifier = K.MARCHANT_ID
        request.supportedNetworks = [.quicPay, .masterCard, .visa]
        request.supportedCountries = ["EG", "US"]
        request.merchantCapabilities = .capability3DS

        if K.CURRENCY == "EGP" {
            request.countryCode = "EG"
            request.currencyCode = "EGP"
     } else {
         request.countryCode = "US"
         request.currencyCode = "USD"
       }
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Shopify", amount: NSDecimalNumber(value: 100 ))]
        return request
    }()
    
    
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
        let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
        if controller != nil {
            controller!.delegate = self
            present(controller!,  animated: true ,completion: nil)
        }

    }
}


extension PaymentViewController : PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
        
    }
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController , didAuthorizePayment payment: PKPayment , handler completion: @escaping (PKPaymentAuthorizationResult) -> Void){
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
}
