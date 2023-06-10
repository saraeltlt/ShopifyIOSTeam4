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
    var isDarkMode: Bool {
        get {
            (UIApplication.shared.delegate as! AppDelegate).overrideApplicationThemeStyle()
            return UserDefaults.standard.bool(forKey: K.APPERANCE_MODE_KEY)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: K.APPERANCE_MODE_KEY)
            (UIApplication.shared.delegate as! AppDelegate).overrideApplicationThemeStyle()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = bgView.bounds.width*0.05
        switchView.isOn = self.isDarkMode
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        
    }
    func configure(index:Int){
        titleLabel.text=settingsElemnts[index]
        switchView.isHidden=true
        switch index{
        case 0:
            detailLabel.text=K.DEFAULT_ADDRESS
            buttonView.isHidden=false
        case 1:
            detailLabel.text=K.CURRENCY
            buttonView.isHidden=false
        case 2:
            detailLabel.text=""
            buttonView.isHidden=false
        case 3:
            detailLabel.text=""
            buttonView.isHidden=false
            
        default:
            switchView.isHidden=false
            buttonView.isHidden=true
            detailLabel.text=self.isDarkMode ? "Dark   ." : "Light   ."
            
        }
        
    }
    
    @IBAction func viewMoreBtn(_ sender: UIButton) {
    }
    @IBAction func switchMood(_ sender: UISwitch) {
        self.isDarkMode = sender.isOn
        detailLabel.text=self.isDarkMode ? "Dark   ." : "Light   ."
    }
}
