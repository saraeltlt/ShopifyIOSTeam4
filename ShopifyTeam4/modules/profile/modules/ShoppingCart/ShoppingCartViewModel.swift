//
//  ShoppingCartViewModel.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 10/06/2023.
//

import Foundation
import Network
class ShoppingCartViewModel{
    var getProductsObservable:Observable<Bool>=Observable(false)
    var subTotal: Double = 0.0
    var cartProducts:[ProductCart] = []

    
    
    func configNavigation() -> AddressViewModel{
        return AddressViewModel(navigationFlag: false, subTotal: subTotal)
    }
    
    func getCartItems(){
        subTotal=0.0
        let realmServices = RealmDBServices.instance
        realmServices.getAllProducts(ofType: ProductCart.self) { [weak self]error, results in
            if let error = error {
                print("Error : \(error)")
            } else {
                self?.cartProducts.removeAll()
                if let results = results {
                    if results.count > 0{
                        for i in 0...results.count - 1{
                            self?.cartProducts.append(
                                ProductCart(id: results[i].id,
                                            name:results[i].name,
                                            image:results[i].image,
                                            price: String(Double(results[i].price)! * Double(results[i].ItemCount)),
                                            ItemCount: results[i].ItemCount, quantity: results[i].quantity)
                            )
                            if (K.CURRENCY == "EGP"){
                               
                                self?.subTotal = self!.subTotal + ( Double(results[i].price)! * Double(results[i].ItemCount) * K.EXCHANGE_RATE)
                            }else{
                                let price =  self!.subTotal + (Double(results[i].price)! * Double(results[i].ItemCount))
                                let formattedPrice = String(format: "%.2f", price) 
                                self?.subTotal = Double(formattedPrice) ?? 0.0
                            }
                        }
             
                    }
                    self?.getProductsObservable.value=true
                    
                }
            }
        }
    }
    
    func deleteProduct(id: Int){
        let realmServices = RealmDBServices.instance
        realmServices.deleteProductById(ofType: ProductCart.self, id: id) { errorMessage in
            self.getCartItems()
        }
    }
    
    func getProduct(index: Int) -> ProductCart{
        return cartProducts[index]
    }
    
    func editItemCount(productId: Int, count:Int){
        let realmServices = RealmDBServices.instance
        realmServices.updateProductCart(id: productId, count: count) {error in
            self.getCartItems()

        }
    }
    
    
    
    
}
