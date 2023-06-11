//
//  CustomAlertViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 11/06/2023.
//

import UIKit

class CustomAlertViewController: UIViewController {


    @IBOutlet weak var myAlertImage: UIImageView!
    @IBOutlet weak var alertTitle: UILabel!
    @IBOutlet weak var okBtnView: UIButton!
    @IBOutlet weak var cancelBtnView: UIButton!
    @IBOutlet weak var alertSubTitle: UILabel!
    var titles:String!
    var subTitle:String!
    var imageName:String!
    var okBtn: String?
    var okBtnHandler : (() -> Void)?
    var cancelBtn:String?
      
    override func viewDidLoad() {
        super.viewDidLoad()
        if (cancelBtn==nil){
            cancelBtnView.isHidden=true
        }else{
            cancelBtnView.isHidden=false
            cancelBtnView.setTitle(cancelBtn, for: .normal)
        }

        okBtnView.setTitle(okBtn, for: .normal)
        alertTitle.text=titles
        alertSubTitle.text=subTitle
        myAlertImage.image=UIImage(named: imageName)

     
    }

    
    @IBAction func saveBtn(_ sender: UIButton) {
        if let handler = okBtnHandler{
          handler()
        }
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }


}
