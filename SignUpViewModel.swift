//
//  SignUpViewModel.swift
//  ShopifyTeam4
//
//  Created by Youssef Mohamed on 09/06/2023.
//

import Foundation
class SignUpViewModel{
    private var authintecationService = AuthenticationService()
    var successClosur:() -> () = {}
    var failClosure:(String) -> () = {_ in }
    func createNewUserWith(user:FUser,password:String){
        authintecationService.createNewUser(user: user, password: password) { [weak self] errorMessage in
            guard let self = self else {return}
            if let errorMessage = errorMessage{
                self.failClosure(errorMessage)
            }else{
                self.successClosur()
            }
        }
    }
}
/*
 if UserDefaults.standard.object(forKey: kCURRENTUSER) != nil{
     // navigate to home directly ..
 }
 */
