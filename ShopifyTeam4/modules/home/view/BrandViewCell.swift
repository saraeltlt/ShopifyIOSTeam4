//
//  BrandViewCell.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 05/06/2023.
//

import UIKit
import SDWebImage
class BrandViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    override func layoutSublayers(of layer: CALayer) {
        outerContainer.layer.cornerRadius = cellFrame.bounds.width * 0.09
        innerContainer.layer.cornerRadius = cellFrame.bounds.width*0.09
    }
    
    
    @IBOutlet weak var numberOfItems: UILabel!
    
    @IBOutlet weak var cellFrame: UIView!
    @IBOutlet weak var addToFavorite: FavoriteButton!
    @IBOutlet weak var outerContainer: UIView!
    
    
    @IBOutlet weak var innerContainer: UIView!
    
    
    @IBOutlet weak var brandImage: UIImageView!
    
    
    @IBOutlet weak var brandName: UILabel!
    
    
    @IBOutlet weak var price: UILabel!
    
    
    
    func configureCell(title:String,imageUrl:String,price:String="",numberOfItems:String=""){
        self.numberOfItems.text = numberOfItems
        brandName.text=title
        brandImage.sd_setImage(with: URL(string: imageUrl), placeholderImage:UIImage(named: "test"))
        if (price == ""){
            self.price.text = ""
        }
        else if (K.CURRENCY == "USD"){
            let formattedPrice = String(format: "%.2f", Double(price)!)
                        self.price.text = "\(formattedPrice) USD"
            
        } else {
            let result = Int(Double(price)! * K.EXCHANGE_RATE)
               self.price.text = "\(result) EGP"
       
            
        }
        
    }

}
