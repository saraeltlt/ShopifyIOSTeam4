//
//  OrderDetailsViewModel.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 15/06/2023.
//

import Foundation
class OrderDetailsViewModel{
    var order:Order?
    init(order: Order? = nil) {
        self.order = order
    }
    func getProductsCount()-> Int{
        return order?.line_items?.count ?? 0
    }
    func getProductData(index:Int)->OrderProduct{
        return (order?.line_items?[index])!
    }
    func configureHeaderData()->(date:String,address:String,price:String){
        let date = order?.created_at?.cutStringIntoComponents()?.date
        let adrress = ""
        var price = Double((order?.current_total_price)!)
        var totalPrice = ""
        if K.CURRENCY == "EGP" {
            price = price! * K.EXCHANGE_RATE
            totalPrice = "\(price!) L.E"
        }else {
            totalPrice = "\(price!) USD"
        }
        return(date!,adrress,totalPrice)
    }
}
