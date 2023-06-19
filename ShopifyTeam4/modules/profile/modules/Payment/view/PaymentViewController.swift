//
//  PaymentViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 07/06/2023.
//

import UIKit
import PassKit

class PaymentViewController: UIViewController {

    @IBOutlet weak var noInternetConnectionView: UIView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var cashBtn: UIButton!
    var viewModel : PaymentViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureInternetConnectionObservation()
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
    
    
    @IBAction func sumbitOrderPayment(_ sender: UIButton) {
        print("post order here")
        viewModel.postOrder()
    }
    
    

    @IBAction func payCash(_ sender: UIButton) {
        onlineBtn.setImage(UIImage(systemName: "circle"), for: .normal)
        cashBtn.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        
    }
    
    @IBAction func payOnline(_ sender: UIButton) {
        onlineBtn.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        cashBtn.setImage(UIImage(systemName: "circle"), for: .normal)
        let controller = PKPaymentAuthorizationViewController(paymentRequest: viewModel.getPaymentRequest())
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
