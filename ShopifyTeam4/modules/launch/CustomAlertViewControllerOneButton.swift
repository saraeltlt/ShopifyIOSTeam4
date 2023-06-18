//
//  CustomAlertViewControllerOneButton.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 18/06/2023.
//

import UIKit

class CustomAlertViewControllerOneButton: UIViewController {
    
    
    @IBOutlet weak var myAlertImage: UIImageView!
    @IBOutlet weak var alertTitle: UILabel!
    @IBOutlet weak var okBtnView: UIButton!
    @IBOutlet weak var alertSubTitle: UILabel!
    var titles:String!
    var subTitle:String!
    var imageName:String!
    var okBtn: String?
    var okBtnHandler : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let font = UIFont(name: "Chalkduster", size: 17.0)!
        var attributedText = NSAttributedString(string: okBtn ?? "Ok", attributes: [NSAttributedString.Key.font: font])
        okBtnView.setAttributedTitle(attributedText, for: .normal)
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
    
    
    
}
