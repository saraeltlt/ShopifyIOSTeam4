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
    
    
    
    @IBOutlet weak var cellFrame: UIView!
    @IBOutlet weak var addToFavorite: UIButton!
    
    @IBOutlet weak var outerContainer: UIView!
    
    
    @IBOutlet weak var innerContainer: UIView!
    
    
    @IBOutlet weak var brandImage: UIImageView!
    
    
    @IBOutlet weak var brandName: UILabel!
    
    
    @IBOutlet weak var price: UILabel!
    
    
    
    func configureCell(title:String,imageUrl:String,price:String=""){
        brandName.text=title
        brandImage.sd_setImage(with: URL(string: imageUrl), placeholderImage:UIImage(named: "test"))
        if (price == ""){
            self.price.text = ""
        }
        else if (K.CURRENCY == "USD"){
            self.price.text = "\(price) USD"
            
        } else {
            NetworkManager.shared.getCurrency(amount: Float (price) ?? 0.0, completionHandler: { [weak self] result in
               self?.price.text = result
            })
            
        }
        
    }
    
    
    
    
    
}