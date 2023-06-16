//
//  AllFavoritesViewModel.swift
//  ShopifyTeam4
//
//  Created by Youssef Mohamed on 16/06/2023.
//

import Foundation
class AllFavoritesViewModel{
    var realmDBServiceInstance = RealmDBServices.instance
    var favoriteProducts:[ProductFavorite] = []
    var successClosure:([ProductFavorite]) -> () = {_ in }
    var failClosure:(String) -> () = {_ in }
    init(){}
    func getAllSotredFavoriteItems(){
        realmDBServiceInstance.getAllProducts(ofType: ProductFavorite.self) { [weak self] errorMessage, products in
            guard let self = self else {return}
            if let errorMessage = errorMessage{
                self.failClosure(errorMessage)
            }else{
                if let products = products{
                    if products.count > 0{
                        for i in 0...(products.count  - 1) {
                            favoriteProducts.append(products[i])
                            print("item \(i) appended and item name is \(favoriteProducts[i].name)")
                        }
                        successClosure(favoriteProducts)
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
                returnMsg="Product removed successfully"
            }
        }
        return returnMsg
    }
}
