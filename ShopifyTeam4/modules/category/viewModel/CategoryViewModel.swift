//
//  CategoryViewModel.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 08/06/2023.
//

import Foundation
import UIKit

class CategoryViewModel{
    var categoryArray:[Category]=[Category(title: "Men", image: UIImage(named: "test")!, isSelected: false, categoryId: 448684196125),Category(title: "Women", image: UIImage(named: "test")!, isSelected: false, categoryId: 448684261661),Category(title: "Kids", image: UIImage(named: "test")!, isSelected: false, categoryId: 448684294429),Category(title: "Sale", image: UIImage(named: "test")!, isSelected: false, categoryId: 448684327197)]
    
    func getCategoriesCount()->Int{
        return categoryArray.count
    }
    
    func getCategoryData(index:Int)->Category{
        return categoryArray[index]
    }
    
    func changeCategoriesIsSelectedStatus(index:Int){
        self.categoryArray.forEach({ item in
            item.isSelected = false
        })
        self.categoryArray[index].isSelected = true
    }
}
