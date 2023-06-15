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
    var imagSrc:String?
    init(variant_id: Int?, quantity: Int?, name: String?, price: Number?, title: String?, imagSrc:String? = nil) {
          self.variant_id = variant_id
          self.quantity = quantity
          self.name = name
          self.price = price
          self.title = title
          self.imagSrc = imagSrc
      }
    enum CodingKeys: String, CodingKey {
           case variant_id
           case quantity
           case name
           case price
           case title
           case imagSrc = "sku"
       }
    
    static func configOrderProducts(productsData : [ProductCart]) -> [OrderProduct] {
        var orderProducts = [OrderProduct]()
        for product in productsData {
            orderProducts.append(OrderProduct(variant_id: product.id, quantity: product.ItemCount, name: product.name, price: .string(product.price), title: product.name , imagSrc: product.image))
        }
        return orderProducts
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
