//
//  ProductFavorite.swift
//  ShopifyTeam4
//
//  Created by Youssef Mohamed on 15/06/2023.
//

import Foundation
import RealmSwift
class ProductFavorite:Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var image : String = ""
    @objc dynamic var price : String = ""
    required convenience init(id:Int,name:String,image:String,price:String){
        self.init()
        self.id = id
        self.name = name
        self.image = image
        self.price = price
    }
    override class func primaryKey() -> String? {
          return "id"
      }
}
