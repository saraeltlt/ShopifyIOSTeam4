//
//  DraftOrderModel.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 14/06/2023.
//

import Foundation
class DraftOrderProduct : Codable{
    var quantity:Int?
    var price:Number?
    var title:String?
    init(quantity: Int?, price: Number?, title: String?) {
           self.quantity = quantity
           self.price = price
           self.title = title
       }
}

class DraftOrder : Codable{
    var id:Int?
    var customer:Customer?
    var line_items:[DraftOrderProduct]?
    init(id: Int?, customer: Customer?, line_items: [DraftOrderProduct]?) {
           self.id = id
           self.customer = customer
           self.line_items = line_items
       }
    
}
class DraftOrderModel : Codable{
    var draft_order : DraftOrder?
    init(draft_order: DraftOrder?) {
           self.draft_order = draft_order
       }
}
