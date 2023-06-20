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
    var phoneNumberClosure:([String]) -> () = {_ in }
    var verfiedUser:FUser?
    func createNewUserWith(user:FUser,password:String){
        authintecationService.createNewUser(user: user, password: password) { [weak self] errorMessage in
            guard let self = self else {return}
            if let errorMessage = errorMessage{
                self.failClosure(errorMessage)
            }else{
                self.verfiedUser = user
                registerNewCustomer()
            }
        }
    }
    
    func registerNewCustomer(){
        let customer = CustomerModel.getCustomer(user: verfiedUser!)

        NetworkManager.shared.addNewCustomer(method:"POST", url: URLs.shared.customersURl(), newCustomer: customer) { [weak self]  result in
            switch result {
            case .success(let customer):
                UserDefaults.selectedUserID = customer.customer?.id ?? 0
                K.USER_ID = customer.customer?.id ?? 0
                self?.addAddress()
            case .failure(let error):
                self?.failClosure(error.localizedDescription)
            }
            

            
        }
    }
    func addAddress(){
        var newAddress = Address(address1: verfiedUser?.street ,city: verfiedUser?.city ,country: verfiedUser?.country, phone: verfiedUser?.fullNumber, isDefault: true)
        print (newAddress)

        NetworkManager.shared.createNewAddress(url: URLs.shared.addAddress(id: K.USER_ID), address: newAddress) { [weak self](result: Result<responseAddress,Error>) in
            switch result{
            case .success(let data):
                print("Default addres set succefually with: ")

                K.DEFAULT_ADDRESS = "\(newAddress.city!) - \(newAddress.country!)"
                UserDefaults.DefaultAddress=K.DEFAULT_ADDRESS
                self?.successClosur()
            case .failure(let error):
                self?.failClosure(error.localizedDescription)
            }
        }
        
    }
    func getStoredPhoneNumber(){
        authintecationService.getUsersPhoneNumbers { phoneNumbers in
            self.phoneNumberClosure(phoneNumbers)
        }
    }
    
    
    
}
/*
 if UserDefaults.standard.object(forKey: kCURRENTUSER) != nil{
 // navigate to home directly ..
 }
 */
