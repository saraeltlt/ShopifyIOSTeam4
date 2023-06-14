//
//  SignInViewModel.swift
//  ShopifyTeam4
//
//  Created by Youssef Mohamed on 09/06/2023.
//

import Foundation
class SignInViewModel{
    private var authintecationService = AuthenticationService()
    var successClosur:() -> () = {}
    var failClosure:(String) -> () = {_ in }    
    func signInWith(email:String, password:String){
        authintecationService.userSignInActionWith(email: email, password: password) { [weak self] errorMessage in
            guard let self = self else {return}
            if let errorMessage = errorMessage{
                self.failClosure(errorMessage)
            }else{
                self.successClosur()
                getUserID(email:email)
            }
        }
    }
    
    func getUserID(email:String){
        NetworkManager.shared.getApiData(url: URLs.shared.searchForCustomer(email: email), completionHandler: {(result : Result<SearchCustomerModel,Error>) in
            switch(result){
            case .success(let data):
                UserDefaults.selectedUserID = data.customers?[0].id ?? 0
                K.USER_ID = data.customers?[0].id ?? 0
                K.FAV_ID = Int(data.customers?[0].favId ?? "") ?? 0
                K.CART_ID = Int(data.customers?[0].cartId ?? "") ?? 0
                print ("here ", K.FAV_ID, K.CART_ID)
                if (K.FAV_ID  != 0){
                    self.getFav()
                }
                if (K.CART_ID  != 0){
                    self.getCart()
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
        )
    }
    
    
    func getFav(){
        NetworkManager.shared.getApiData(url:URLs.shared.getDaftOrder(draftOrderId:   K.FAV_ID)) { [weak self] (result:Result<DraftOrderModel,Error>) in
            switch result{
            case .success(let mode):
                print ("ya mosahel omr fav", mode.draft_order?.line_items) //add to realm
            case .failure(let error):
                print (error.localizedDescription)
            }
        }
        
    }
    func getCart(){
        NetworkManager.shared.getApiData(url:URLs.shared.getDaftOrder(draftOrderId:   K.CART_ID)) { [weak self] (result:Result<DraftOrderModel,Error>) in
            switch result{
            case .success(let mode):
                print ("ya mosahel omr cart", mode.draft_order?.line_items) //add to realm
            case .failure(let error):
                print (error.localizedDescription)
            }
        }
        
    }
    
    
}
