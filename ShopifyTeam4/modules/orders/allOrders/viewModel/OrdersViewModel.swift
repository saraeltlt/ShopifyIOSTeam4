//
//  OrdersViewModel.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 11/06/2023.
//

import Foundation
class OrdersViewModel{
    var orders:[Order]?
    init(orders: [Order]? = nil) {
        self.orders = orders
    }
  
    func getordersCount()->Int{
        return orders?.count ?? 0
    }
    func getOrderData(index:Int)->Order{
        return (orders?[index])!
    }
    
    func configureNavigationToOrderDetails(index:Int)->OrderDetailsViewModel{
        let order = orders?[index]
        return OrderDetailsViewModel(order: order)
    }
    
    
    
    
}
