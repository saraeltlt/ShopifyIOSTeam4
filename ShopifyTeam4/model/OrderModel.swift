//
//  File.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 11/06/2023.
//

import Foundation
import RealmSwift

struct OrderProduct : Codable{
    var variant_id : Int?
    var quantity:Int?
    var name:String?
    var price:Float?
    var title:String?
}

struct Order : Codable{
    var id:Int?
    var customer:Customer?
    var line_items:[OrderProduct]?
    var created_at:String?
    var financial_status: String?
    var current_total_price:String?

}
struct OrderModel : Codable{
    var order : Order
}
