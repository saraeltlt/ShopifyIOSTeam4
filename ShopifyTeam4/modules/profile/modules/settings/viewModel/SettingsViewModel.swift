//
//  SettingsViewModel.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 14/06/2023.
//

import Foundation
class SettingsViewModel{
    
    
    func getAllShopingCartItems()->[DraftOrderProduct]{
        var cartProducts = [DraftOrderProduct]()
        let realmServices = RealmDBServices.instance
        realmServices.getAllProducts(ofType: ProductCart.self) { [weak self]error, results in
            if let error = error {
                print("Error : \(error)")
            } else {
                if let results = results {
                    if results.count > 0{
                        for i in 0...results.count - 1{
                            cartProducts.append(
                                DraftOrderProduct(quantity: results[i].ItemCount, price: .string(results[i].price), title: "\(results[i].name)?\(results[i].id)", imagSrc: "\(results[i].image)$\(results[i].quantity)")
                            
                            )
                        }
                    }
                }
            }
           
        }
        return cartProducts
    }
    
    
    
    func getAllfavItems()->[DraftOrderProduct]{
        var favProducts = [DraftOrderProduct]()
        let realmServices = RealmDBServices.instance
        realmServices.getAllProducts(ofType: ProductFavorite.self) { [weak self]error, results in
            if let error = error {
                print("Error : \(error)")
            } else {
                if let results = results {
                    if results.count > 0{
                        for i in 0...results.count - 1{
                            favProducts.append(
                                DraftOrderProduct(quantity: 1, price: .string(results[i].price), title: "\(results[i].name)?\(results[i].id)", imagSrc: results[i].image)
                            
                            )
                        }
                    }
                }
            }
           
        }
        return favProducts
    }
    func userLogout(){
        AuthenticationService.userLogout()
        UserDefaults.standard.set(nil, forKey: kCURRENTUSER)
        K.USER_NAME = ""
    }
    func saveUserData(){
        let order = DraftOrder(id: nil, customer: nil, line_items:getAllfavItems())
        
        //.......
        if !(order.line_items!.isEmpty){
            let draftOrder = DraftOrderModel(draft_order: order)
            NetworkManager.shared.addDraftOrder(method: "POST", url: URLs.shared.postDraftOrder(), order: draftOrder) { (result: Result<DraftOrderModel, Error> ) in
                switch result{
                case .success(let favData):
                    K.FAV_ID = (favData.draft_order?.id!)!
                    UserDefaults.selectedFavID = K.FAV_ID
                    print ("fav ------------------------")
                    print ( K.FAV_ID)
                    print ("------------------------")
                    self.getCartID()
                case .failure(let error):
                    print (error)
                }
            }
        }
        else{
            K.FAV_ID = 0
            self.getCartID()
            UserDefaults.selectedFavID = K.FAV_ID
        }
    }
    
    
    func getCartID(){
        let order = DraftOrder(id: nil, customer: nil, line_items:getAllShopingCartItems())
        if !(order.line_items!.isEmpty){
            let draftOrder = DraftOrderModel(draft_order: order)
            NetworkManager.shared.addDraftOrder(method: "POST", url: URLs.shared.postDraftOrder(), order: draftOrder) { (result: Result<DraftOrderModel, Error> ) in
                switch result{
                case .success(let cartData):
                    print(cartData)
                    K.CART_ID = (cartData.draft_order?.id!) ?? 0
                    UserDefaults.selectedCartID = K.CART_ID
                    print ("cart------------------------")
                    print ( K.CART_ID)
                    print ("------------------------")
                    self.updateCustomer()
                    
                case .failure(let error):
                    print (error)
                }
            }
        }
        else{
            K.CART_ID = 0
            updateCustomer()
            UserDefaults.selectedCartID = K.CART_ID
        }
    }
    
    
    func updateCustomer(){
        let customer = CustomerModel(customer: Customer(id: K.USER_ID, note: String(K.FAV_ID), tags: String(K.CART_ID)))
        NetworkManager.shared.addNewCustomer(method:"PUT", url: URLs.shared.updateCustomers(id: K.USER_ID), newCustomer: customer) {result in
            switch result {
            case .success(let customer):
                   print ("customer ------------------------")
                   let realmServices = RealmDBServices.instance
                   realmServices.deleteAllProducts(ofType: ProductCart.self) { errorMessage in
                       print("cart-> ", errorMessage)
                   }
                   realmServices.deleteAllProducts(ofType: ProductFavorite.self) { errorMessage in
                       print("fav-> ", errorMessage)
                   }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

}
