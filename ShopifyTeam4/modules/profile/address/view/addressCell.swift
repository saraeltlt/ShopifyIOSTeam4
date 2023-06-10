//
//  addressCell.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 06/06/2023.
//

import UIKit

class addressCell: UITableViewCell {
    
    @IBOutlet weak var phoneNumber: UIButton!
    @IBOutlet weak var addressDetails: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configure(phoneNum:String, Address:String){
        phoneNumber.subtitleLabel?.text = phoneNum
        addressDetails.subtitleLabel?.text = Address
        
    }
    
}
