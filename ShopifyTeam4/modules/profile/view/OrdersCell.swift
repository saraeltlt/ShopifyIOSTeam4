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
    
    func configure(date:String,price:String){
        var price = Double(price)
        let year = date.cutStringIntoComponents()?.year
        let month = date.cutStringIntoComponents()?.month
        let day = date.cutStringIntoComponents()?.day
        let time = date.cutStringIntoComponents()?.time
        dateLabel.text = "\(year!)/\(month!)/\(day!)"
        if K.CURRENCY == "EGP" {
            price = (price ?? 0.0) * K.EXCHANGE_RATE
            priceBtnText.setTitle("\(price!) L.E", for: .normal)
        }else {
            priceBtnText.setTitle("\(price!) USD", for: .normal)
        }
   
    }

    
}
