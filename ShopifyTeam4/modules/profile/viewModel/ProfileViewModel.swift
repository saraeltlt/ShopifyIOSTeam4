//
//  ProfileViewModel.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 12/06/2023.
//

import Foundation
class ProfileViewModel{
    var favoriteProducts:[ProductFavorite] = []
    var realmDBServiceInstance = RealmDBServices.instance
    var successClosure:() -> () = {}
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
    func getAllSotredFavoriteItems(){
        realmDBServiceInstance.getAllProducts(ofType: ProductFavorite.self) { [weak self] errorMessage, products in
            guard let self = self else {return}
            if let errorMessage = errorMessage{
               // self.failClosure(errorMessage)
            }else{
                if let products = products{
                    if products.count > 0{
                        for i in 0...(products.count  - 1) {
                            favoriteProducts.append(products[i])
                            print("item \(i) appended and item name is \(favoriteProducts[i].name)")
                        }
                        self.successClosure()
                    }
                }
            }
        }
    }
    func addToFavorite(product:ProductFavorite) -> String{
        let realmServices = RealmDBServices.instance
        var returnMsg:String = ""
        realmServices.addProduct(product: product) { error in
            if let error = error {
                returnMsg="Error adding product: \(error)"
            } else {
                returnMsg="Product added successfully"
            }
        }
        return returnMsg
    }
    func removeFromFavorite(productId:Int) -> String{
        let realmServices = RealmDBServices.instance
        var returnMsg:String = ""
        realmServices.deleteProductById(ofType: ProductFavorite.self, id: productId) { errorMessage in
            if let error = errorMessage {
                returnMsg="Error when removing product: \(error)"
            } else {
                self.favoriteProducts = []
                returnMsg="Product removed successfully"
            }
        }
        return returnMsg
    }
}
