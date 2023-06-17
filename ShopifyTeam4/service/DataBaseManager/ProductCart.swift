//
//  ProductCart.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 15/06/2023.
//

import Foundation
import RealmSwift
class ProductCart:Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var image : String = ""
    @objc dynamic var price : String = ""
    @objc dynamic var ItemCount : Int = 1
    @objc dynamic var quantity : Int = 1
    
    override class func primaryKey() -> String? {
          return "id"
      }
    
    required convenience init(id:Int,name:String,image:String,price:String, ItemCount:Int, quantity: Int){
        self.init()
        self.id = id
        self.name = name
        self.image = image
        self.price = price
        self.ItemCount=ItemCount
        self.quantity=quantity
    }
    
}
