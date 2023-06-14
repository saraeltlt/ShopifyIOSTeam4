//
//  SettingsViewModel.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 14/06/2023.
//

import Foundation
class SettingsViewModel{
    
    
    func saveUserData(){

        
        let FavOperation = BlockOperation {
            let orderProduct = DraftOrderProduct( quantity: 4, price:  .string("332232"), title: "Fav product")
            let order = DraftOrder(id: nil, customer: nil, line_items: [orderProduct] )
            let draftOrder = DraftOrderModel(draft_order: order)
            
            NetworkManager.shared.addDraftOrder(method: "POST", url: URLs.shared.postDraftOrder(), order: draftOrder) { (result: Result<DraftOrderModel, Error> ) in
                switch result{
                case .success(let favData):
                    K.FAV_ID = (favData.draft_order?.id!)!
                    UserDefaults.selectedFavID = K.FAV_ID
                    print ("fav ------------------------")
                    print ( K.FAV_ID)
                    print ("------------------------")
                case .failure(let error):
                    print (error)
                }
            }
            
        }
        
        let cartOperation = BlockOperation {
            let orderProduct = DraftOrderProduct( quantity: 4, price:  .string("332232"), title: "Cart product")
            let order = DraftOrder(id: nil, customer: nil, line_items: [orderProduct] )
            let draftOrder = DraftOrderModel(draft_order: order)
            NetworkManager.shared.addDraftOrder(method: "POST", url: URLs.shared.postDraftOrder(), order: draftOrder) { (result: Result<DraftOrderModel, Error> ) in
                switch result{
                case .success(let cartData):
                    print(cartData)
                    K.CART_ID = (cartData.draft_order?.id!)!
                    UserDefaults.selectedCartID = K.CART_ID
                    print ("cart------------------------")
                    print ( K.CART_ID)
                    print ("------------------------")
                    
                case .failure(let error):
                    print (error)
                }
            }
            

            
        }
        let putCustomerOperation = BlockOperation{
            let customer = CustomerModel(customer: Customer(id: K.USER_ID, note: String(K.FAV_ID), tags: String(K.CART_ID)))
            NetworkManager.addNewCustomer(method:"PUT", url: URLs.shared.updateCustomers(id: K.USER_ID), Newcustomer: customer) { customer in
                guard let customer = customer else {return}
                print ("customer ------------------------")
            }
        }
        
        putCustomerOperation.addDependency(cartOperation)
        cartOperation.addDependency(FavOperation)
       
        
        let operationQueue = OperationQueue()
        operationQueue.addOperations([FavOperation, cartOperation, putCustomerOperation], waitUntilFinished: true)
    }
}
