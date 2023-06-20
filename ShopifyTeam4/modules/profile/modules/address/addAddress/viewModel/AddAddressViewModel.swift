//
//  AddAddressViewModel.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 11/06/2023.
//

import Foundation
class AddAddressViewModel{
    var errorMsg : String?
    var newAddress:Address?
    var addAddressObservable:Observable<String>=Observable("nil")
    
    func addAddress(phone: String, street: String, city: String, country: String){
        newAddress = Address(address1: street, city: city, country: country, phone: phone )
        
        NetworkManager.shared.createNewAddress(url: URLs.shared.addAddress(id: K.USER_ID), address: newAddress!) {[weak self](result: Result<responseAddress,Error>) in
            switch result{
            case .success(let data):
                self?.newAddress?.id=data.customer_address?.id
                self?.addAddressObservable.value="success"
            case .failure(let error):
                self?.addAddressObservable.value="error"
                self?.errorMsg = error.localizedDescription
            }
        }
    
    }
    

    
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let digitPattern = #"^\d+$"#
        let digitRegex = try! NSRegularExpression(pattern: digitPattern)
        let phonePattern = #"^\+?\d{1,3}?[-.\s]?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}$"#
        let phoneRegex = try! NSRegularExpression(pattern: phonePattern)
        let isDigitOnly = digitRegex.matches(in: phoneNumber, range: NSRange(location: 0, length: phoneNumber.count)).count > 0
        let isPhoneNumberValid = phoneRegex.matches(in: phoneNumber, range: NSRange(location: 0, length: phoneNumber.count)).count > 0
        return isDigitOnly && isPhoneNumberValid
    }
}
