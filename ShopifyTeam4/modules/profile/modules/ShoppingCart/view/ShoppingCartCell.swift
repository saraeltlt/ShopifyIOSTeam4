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

    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    var productId=0
    var quantity=1
    var viewModel = ShoppingCartViewModel()
    var price = 0.0
    var view = UIView()
    @IBOutlet weak var itemCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSublayers(of layer: CALayer) {
        imageBG.layer.cornerRadius = imageBG.layer.frame.width*0.15
        productImage.layer.cornerRadius = productImage.layer.frame.width*0.15
        productBG.layer.cornerRadius = productBG.layer.frame.width*0.07
        
    }
    
    func configure(id:Int,name:String,price:String,ImageUrl:String, itemCount:Int, viewModel: ShoppingCartViewModel ,quantity:Int, view: UIView){
        self.productId = id
        self.viewModel = viewModel
        self.quantity = quantity
        self.view = view
        if (K.CURRENCY == "EGP"){
            let formattedPrice = String(format: "%.2f", Double(price)!)
            let priceConvert = Double(formattedPrice)! * K.EXCHANGE_RATE
            productPrice.text = String(priceConvert) + " EGP"
            self.price = priceConvert
        }else{
            let formattedPrice = String(format: "%.2f", Double(price)!)
            productPrice.text = formattedPrice + " USD"
            self.price = Double(formattedPrice)!
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
        if (itemCount<quantity){
            itemCount+=1
            itemCountLabel.text = "\(itemCount)"
            if (K.CURRENCY == "EGP"){
                productPrice.text = "\(price * Double(itemCount)) EGP"
            }else{
                productPrice.text = "\(price * Double(itemCount)) USD"
            }
            viewModel.editItemCount(productId: productId, count: itemCount)
        }else{
            self.view.makeToast("Can't add more than \(itemCount) from this product", duration: 2 ,title: "Warning" ,image: UIImage(named: K.WARNINNG_IMAGE))
        }
        
    }
    
    @IBAction func SubBtn(_ sender: UIButton) {
        var itemCount = Int(itemCountLabel.text!)!
        if (itemCount>1){
            itemCount-=1
            itemCountLabel.text = "\(itemCount)"
            if (K.CURRENCY == "EGP"){
                productPrice.text = "\(price * Double(itemCount)) EGP"
            }else{
                productPrice.text = "\(price * Double(itemCount)) USD"
            }
            viewModel.editItemCount(productId: productId, count: itemCount)
        }else if (itemCount==1){
            viewModel.deleteProduct(id: productId)
        }
    }
}
