//
//  CategoryViewCell.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 06/06/2023.
//

import UIKit

class CategoryViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    override func layoutSublayers(of layer: CALayer) {
        self.container.layer.cornerRadius = cellView.bounds.height*0.17
        self.container.layer.masksToBounds = true
    }
    
    
    func configureCell(title:String,image:UIImage){
        categoryTitle.text=title
        categoryImage.image=image
      
        
    }
    
    
    
    @IBOutlet weak var cellView: UIView!
    
    
    
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var categoryImage: UIImageView!
    
    
    @IBOutlet weak var categoryTitle: UILabel!
    
}
