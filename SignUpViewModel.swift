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
        let customer = CustomerModel.getCustomer(user: verfiedUser!)
        NetworkManager.addNewCustomer(method:"POST", url: URLs.shared.customersURl(), Newcustomer: customer) { customer in
            guard let customer = customer else {return}
            UserDefaults.selectedUserID = customer.customer?.id ?? 0
            K.USER_ID = customer.customer?.id ?? 0
            self.addAddress()
            
        }
    }
    func addAddress(){
        var newAddress = Address(address1: verfiedUser?.street ,city: verfiedUser?.city ,country: verfiedUser?.country, phone: verfiedUser?.fullNumber, isDefault: true)
        print (newAddress)
        NetworkManager.shared.addNewAddress(url: URLs.shared.addAddress(id: K.USER_ID), newAddress: newAddress) {(result: Result<Int,Error>) in
            print ("here")
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
