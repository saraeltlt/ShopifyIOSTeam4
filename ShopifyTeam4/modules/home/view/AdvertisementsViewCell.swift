//
//  AdvertisementsViewCell.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 04/06/2023.
//

import UIKit

class AdvertisementsViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSublayers(of layer: CALayer) {
        self.layer.cornerRadius = container.bounds.height * 0.15
         self.layer.masksToBounds = true
    }
    
    
    
    
    func configureCell(image:UIImage){
        adsImage.image=image
      
    }
    
    
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var adsImage: UIImageView!
    
    
}
