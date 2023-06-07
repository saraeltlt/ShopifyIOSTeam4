//
//  Category.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 06/06/2023.
//

import Foundation
import UIKit
class Category{
    var title:String
    var image:UIImage
    var isSelected:Bool
    init(title: String, image: UIImage, isSelected: Bool) {
        self.title = title
        self.image = image
        self.isSelected = isSelected
    }
}
