//
//  File.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 11/06/2023.
//

import Foundation
import RealmSwift

class OrderProduct : Codable{
    var variant_id : Int?
    var quantity:Int?
    var name:String?
    var price:Number?
    var title:String?
    init(variant_id: Int?, quantity: Int?, name: String?, price: Number?, title: String?) {
          self.variant_id = variant_id
          self.quantity = quantity
          self.name = name
          self.price = price
          self.title = title
      }
}

class Order : Codable{
    var id:Int?
    var customer:Customer?
    var line_items:[OrderProduct]?
    var created_at:String?
    var financial_status: String?
    var current_total_price:String?
    init(id: Int?, customer: Customer?, line_items: [OrderProduct]?, created_at: String?, financial_status: String?, current_total_price: String?) {
          self.id = id
          self.customer = customer
          self.line_items = line_items
          self.created_at = created_at
          self.financial_status = financial_status
          self.current_total_price = current_total_price
      }

}
class OrderModel : Codable{
    var order : Order
    init(order: Order) {
           self.order = order
       }
}


class GetOrderModel : Codable{
    var orders : [Order]
    init(orders: [Order]) {
           self.orders = orders
       }
}

class PostOrderModel : Codable{
    var order : Order
    init(order: Order) {
           self.order = order
       }
}
