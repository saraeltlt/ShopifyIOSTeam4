//
//  ProfileViewModel.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 12/06/2023.
//

import Foundation
class ProfileViewModel{
    var orders:Observable<Bool>=Observable(false)
    var ordersArray = [Order]()
    func configureNavigationToAllOrders()->OrdersViewModel{
        return OrdersViewModel(orders: ordersArray)
    }
    func getAllOrders(){
        NetworkManager.shared.getApiData(url: URLs.shared.getOrders(customerId: K.USER_ID)) { [weak self] (result : Result<GetOrderModel,Error>) in
            switch(result){
            case .success(let data):
                self?.ordersArray = data.orders
                self?.orders.value = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    func getordersCount()->Int{
        if ordersArray.isEmpty {
            return 0
        }else {
          return 2
        }
    }
    func getOrderData(index:Int)->Order{
        return ordersArray[index]
    }
}
