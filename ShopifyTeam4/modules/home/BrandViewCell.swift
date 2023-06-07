//
//  BrandViewCell.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 05/06/2023.
//

import UIKit

class BrandViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    override func layoutSublayers(of layer: CALayer) {
        outerContainer.layer.cornerRadius = cellFrame.bounds.width * 0.05
        innerContainer.layer.cornerRadius = cellFrame.bounds.width*0.09
    }
    
    @IBOutlet weak var cellFrame: UIView!
    
    
    
    @IBOutlet weak var addToFavorite: UIButton!
    
    @IBOutlet weak var outerContainer: UIView!
    
    
    @IBOutlet weak var innerContainer: UIView!
    
    
    @IBOutlet weak var brandImage: UIImageView!
    
    
    @IBOutlet weak var brandName: UILabel!
    
    
    
    
    
    func setUpCell(title:String,imageUrl:String){
        brandName.text=title
        brandImage.image=UIImage(named: imageUrl)
      
        
    }
    
    
    
    
    
}
