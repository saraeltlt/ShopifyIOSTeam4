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
            let realmServices = RealmDBServices.instance
            switch result{
            case .success(let mode):
                for item in (mode.draft_order?.line_items!)!{
                    let (title, id) = self!.extractSubstring(from: item.title!, delimiter: "?")
                    let product = ProductFavorite(id:Int(id!)!, name: title!, image: item.imagSrc!, price: (item.price?.stringValue())!)
                    realmServices.addProduct(product: product) { error in
                        if let error = error {
                            print("Error adding product: \(error)")
                        } else {
                            print("Product added successfully with id \(id)")
                            
                        }
                    }
                }
                NetworkManager.shared.putOrDeleteApiData(method: "DELETE", url: URLs.shared.getDaftOrder(draftOrderId: K.FAV_ID)) { (result : Result<(Int,String),Error>) in
                    switch (result){
                    case .success(let status):
                        print(status.0,status.1)
                        print("iam in sucess")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                print (error.localizedDescription)
            }
        }
        
    }
    
    
    
    
    
    
    func getCart(){
        let realmServices = RealmDBServices.instance
        NetworkManager.shared.getApiData(url:URLs.shared.getDaftOrder(draftOrderId:   K.CART_ID)) { [weak self] (result:Result<DraftOrderModel,Error>) in
            switch result{
            case .success(let mode):
                for item in (mode.draft_order?.line_items!)!{
                    let (title, id) = self!.extractSubstring(from: item.title!, delimiter: "?")
                    let (image, allQuantity) = self!.extractSubstring(from: item.imagSrc!, delimiter: "$")
                    let product = ProductCart(id:Int(id!)!, name: title!, image:image!, price: (item.price?.stringValue())!, ItemCount: item.quantity!, quantity: Int(allQuantity!)!)
                    realmServices.addProduct(product: product) { error in
                        if let error = error {
                            print("Error adding product: \(error)")
                        } else {
                            print("Product added successfully with id \(id)")
                            
                        }
                    }
                }
                
                NetworkManager.shared.putOrDeleteApiData(method: "DELETE", url: URLs.shared.getDaftOrder(draftOrderId: K.CART_ID)) { (result : Result<(Int,String),Error>) in
                    switch (result){
                    case .success(let status):
                        print(status.0,status.1)
                        print("iam in sucess")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                print (error.localizedDescription)
            }
        }
        
    }
    
    
    
    func extractSubstring(from inputString: String, delimiter: Character) -> (String?, String?) {
        let components = inputString.split(separator: delimiter)
        guard let firstComponent = components.first else {
            return (nil, nil)
        }
        
        let substringBefore = String(firstComponent)
        
        if components.count > 1 {
            let substringAfter = String(components[1])
            return (substringBefore, substringAfter)
        } else {
            return (substringBefore, nil)
        }
    }
    
    
}
