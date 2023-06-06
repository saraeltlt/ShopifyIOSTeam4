//
//  OrdersCell.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 06/06/2023.
//

import UIKit

class OrdersCell: UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceBtnText: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(){
        dateLabel.text = "22 - 11 - 2022"
        priceBtnText.setTitle("300 LE", for: .normal)
    }

    
}
