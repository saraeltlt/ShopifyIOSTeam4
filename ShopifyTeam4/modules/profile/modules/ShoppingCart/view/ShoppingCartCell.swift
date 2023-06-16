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
    var productId=0
    var viewModel = ShoppingCartViewModel()
    var price = 0.0
    @IBOutlet weak var itemCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSublayers(of layer: CALayer) {
        imageBG.layer.cornerRadius = imageBG.layer.frame.width*0.15
        productBG.layer.cornerRadius = productBG.layer.frame.width*0.07
        
    }
    
    func configure(id:Int,name:String,price:String,ImageUrl:String, itemCount:Int, viewModel: ShoppingCartViewModel ){
        productId = id
        self.viewModel = viewModel
        if (K.CURRENCY == "EGP"){
            let priceConvert = Double(price)! * K.EXCHANGE_RATE
            productPrice.subtitleLabel?.text = String(priceConvert) + " EGP"
            self.price = priceConvert
        }else{
            productPrice.subtitleLabel?.text = price + " USD"
            self.price = Double(price)!
        }
      
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
        if (K.CURRENCY == "EGP"){
            productPrice.subtitleLabel?.text = "\(price * Double(itemCount)) EGP"
        }else{
            productPrice.subtitleLabel?.text = "\(price * Double(itemCount)) USD"
        }
        viewModel.editItemCount(productId: productId, count: itemCount)
        
    }
    
    @IBAction func SubBtn(_ sender: UIButton) {
        var itemCount = Int(itemCountLabel.text!)!
        if (itemCount>1){
            itemCount-=1
            itemCountLabel.text = "\(itemCount)"
            if (K.CURRENCY == "EGP"){
                productPrice.subtitleLabel?.text = "\(price * Double(itemCount)) EGP"
            }else{
                productPrice.subtitleLabel?.text = "\(price * Double(itemCount)) USD"
            }
            viewModel.editItemCount(productId: productId, count: itemCount)
        }else if (itemCount==1){
            viewModel.deleteProduct(id: productId)
        }
    }
}
