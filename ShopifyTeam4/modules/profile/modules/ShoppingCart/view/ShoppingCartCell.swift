//
//  ShoppingCartCell.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 07/06/2023.
//

import UIKit

class ShoppingCartCell: UITableViewCell {

    @IBOutlet weak var productBG: UIView!
    @IBOutlet weak var imageBG: UIView!
    @IBOutlet weak var productPrice: UIButton!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var itemCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSublayers(of layer: CALayer) {
        imageBG.layer.cornerRadius = imageBG.layer.frame.width*0.15
        productBG.layer.cornerRadius = productBG.layer.frame.width*0.07
        
    }
    
    func configure(name:String,price:String,ImageUrl:String, itemCount:Int ){
        productPrice.subtitleLabel?.text = String(price)
        productNameLabel.text = name
        productImage.sd_setImage(with:URL(string:  ImageUrl), placeholderImage: UIImage(named: "test"), context: nil)
        itemCountLabel.text = String(itemCount)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func addBtn(_ sender: UIButton) {
      var itemCount = Int(itemCountLabel.text!)!
        itemCount+=1
        itemCountLabel.text = "\(itemCount)"
        
    }
    
    @IBAction func SubBtn(_ sender: UIButton) {
        var itemCount = Int(itemCountLabel.text!)!
        itemCount-=1
          itemCountLabel.text = "\(itemCount)"
    }
}
