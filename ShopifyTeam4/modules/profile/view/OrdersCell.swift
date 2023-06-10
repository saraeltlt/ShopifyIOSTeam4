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
    
    func configure(date:String,price:Int){
        dateLabel.text = date
        priceBtnText.setTitle("\(price)", for: .normal)
    }

    
}
