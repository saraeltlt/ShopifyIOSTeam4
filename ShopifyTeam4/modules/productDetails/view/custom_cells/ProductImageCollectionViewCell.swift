//
//  ProductImageCollectionViewCell.swift
//  ShopifyTeam4
//
//  Created by Youssef Mohamed on 10/06/2023.
//

import UIKit

class ProductImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageBackgroundView: UIView!{
        didSet{
            self.imageBackgroundView.layer.cornerRadius = imageBackgroundView.frame.width * 0.15
        }
    }
    @IBOutlet weak var imageView: UIImageView!{
        didSet{
            self.imageView.layer.cornerRadius = imageView.frame.width * 0.15
        }
    }
    
}
