//
//  SettingsViewModel.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 14/06/2023.
//

import Foundation
class SettingsViewModel{
    
    
    func saveUserData(){
        
        //remove this and get realm data
        // let orderProduct = DraftOrderProduct( quantity: 4, price:  .string("332232"), title: "Fav product")
        //  let order = DraftOrder(id: nil, customer: nil, line_items: [orderProduct] )
        let orderProducts = [DraftOrderProduct]()
        let order = DraftOrder(id: nil, customer: nil, line_items: orderProducts)
        
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
        //  let orderProducts = DraftOrderProduct( quantity: 4, price:  .string("332232"), title: "Cart product")
        let orderProducts = [DraftOrderProduct]()
        let order = DraftOrder(id: nil, customer: nil, line_items: orderProducts)
    
        //.......
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
        NetworkManager.addNewCustomer(method:"PUT", url: URLs.shared.updateCustomers(id: K.USER_ID), Newcustomer: customer) { customer in
            guard let customer = customer else {return}
            print ("customer ------------------------")
        }
    }
}