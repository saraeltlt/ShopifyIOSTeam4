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
    var verfiedUser:FUser?
    func createNewUserWith(user:FUser,password:String){
        authintecationService.createNewUser(user: user, password: password) { [weak self] errorMessage in
            guard let self = self else {return}
            if let errorMessage = errorMessage{
                self.failClosure(errorMessage)
            }else{
                self.successClosur()
                self.verfiedUser = user
                registerNewCustomer()
            }
        }
    }
    
    func registerNewCustomer(){
        NetworkManager.addNewCustomer(url: URLs.shared.customersURl(), Newcustomer: CustomerModel.getCustomer(user: verfiedUser!)) { customer in
            guard let customer = customer else {return}
            print(customer.customer?.id)
            UserDefaults.selectedUserID = customer.customer?.id ?? 0
            K.USER_ID = customer.customer?.id ?? 0
            
        }
        var newAddress = Address(address1: verfiedUser?.street ,city: verfiedUser?.city ,country: verfiedUser?.country, phone: verfiedUser?.fullNumber, isDefault: true)
        NetworkManager.shared.addNewAddress(url: URLs.shared.addAddress(id: K.USER_ID), newAddress: newAddress) {(result: Result<Int,Error>) in
            switch result{
            case .success(let data):
                print("Default addres set succefually with: ")
                print (data)
            case .failure(let error):
                print (error)
            }
        }
    }
    
    
    
    
}
/*
 if UserDefaults.standard.object(forKey: kCURRENTUSER) != nil{
     // navigate to home directly ..
 }
 */
