//
//  OrdersCell.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 06/06/2023.
//

import UIKit

class OrdersCell: UITableViewCell {
    @IBOutlet weak var bgView: UIView!

    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        bgView.layer.cornerRadius=bgView.bounds.width * 0.06
        bgView.layer.borderWidth = 2.0
        bgView.layer.borderColor = UIColor(named: K.ORANGE)?.cgColor
    }
    
    func configure(date:String,price:String){
        var price = Double(price)
        let year = date.cutStringIntoComponents()?.year
        let month = date.cutStringIntoComponents()?.month
        let day = date.cutStringIntoComponents()?.day
        let time = date.cutStringIntoComponents()?.time
        yearLabel.text=year
        dayLabel.text=day
        monthLabel.text=getMonthName(for: Int(month!)!)
        timeLabel.text=time
        if K.CURRENCY == "EGP" {
            price = (price ?? 0.0) * K.EXCHANGE_RATE
            priceLabel.text="\(price!) EGP"
        }else {
            priceLabel.text="\(price!) USD"
        }
   
    }
    
    func getMonthName(for monthNumber: Int) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        
        guard let date = Calendar.current.date(from: DateComponents(year: 2000, month: monthNumber, day: 1)) else {
            return nil
        }
        
        return dateFormatter.string(from: date)
    }

    
}
