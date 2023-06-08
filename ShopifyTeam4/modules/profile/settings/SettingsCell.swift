//
//  SettingsCell.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 06/06/2023.
//

import UIKit

class SettingsCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var buttonView: UIButton!
    @IBOutlet weak var switchView: UISwitch!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var settingsElemnts = ["Address", "Currency", "Contact us", "About us", "Apperance"]
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = bgView.bounds.width*0.05
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        
    }
    func configure(index:Int){
        titleLabel.text=settingsElemnts[index]
        switchView.isHidden=true
        switch index{
        case 0:
            detailLabel.text="Alexandria"
        case 1:
            detailLabel.text=K.CURRENCY
        case 2:
            detailLabel.text=""
        case 3:
            detailLabel.text=""
            
        default:
            switchView.isHidden=false
            buttonView.isHidden=true
            detailLabel.text=""
            
        }
        
    }
    
    @IBAction func viewMoreBtn(_ sender: UIButton) {
    }
    @IBAction func switchMood(_ sender: UISwitch) {
    }
}
