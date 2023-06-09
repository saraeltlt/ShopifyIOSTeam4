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
            }
        }
    }
}
