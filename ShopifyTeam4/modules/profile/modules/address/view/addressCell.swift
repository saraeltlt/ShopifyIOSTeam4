//
//  addressCell.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 06/06/2023.
//

import UIKit

class addressCell: UITableViewCell {
    
    @IBOutlet weak var defaultView: UIView!
    
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var defaultBtn: UIButton!
    
    @IBOutlet weak var addressDetails: UILabel!
    var delegate: UpdateData!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configure(address:Address){
        phoneNumber.text = address.phone
        addressDetails.text = "\(address.address1 ?? "") - \(address.city ?? "") - \(address.country ?? "") "
        if (address.isDefault){
            K.DEFAULT_ADDRESS = "\(address.city!) - \(address.country!)"
            UserDefaults.DefaultAddress=K.DEFAULT_ADDRESS
            delegate.reloadTable()
        }
        
    }
    
}
