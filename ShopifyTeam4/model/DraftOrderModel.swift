//
//  DraftOrderModel.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 14/06/2023.
//

import Foundation
struct DraftOrderProduct : Codable{
    var quantity:Int?
    var price:Number?
    var title:String?
}

struct DraftOrder : Codable{
    var id:Int?
    var customer:Customer?
    var line_items:[DraftOrderProduct]?
    
}
struct DraftOrderModel : Codable{
    var draft_order : DraftOrder?
}
