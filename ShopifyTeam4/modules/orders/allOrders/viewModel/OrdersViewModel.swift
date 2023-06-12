//
//  OrdersViewModel.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 11/06/2023.
//

import Foundation
class OrdersViewModel{
    func getUserOrders(){
        let url = URLs.shared.getOrders(customerId: 7010272051485)
        NetworkManager.shared.getApiData(url: url) { [weak self] (result:Result<GetOrderModel,Error>) in
            switch result{
            case .success(let mode):
                print (mode.orders.count)
            case .failure(let error):
                print (error.localizedDescription)
            }
        }
        
    }
}
