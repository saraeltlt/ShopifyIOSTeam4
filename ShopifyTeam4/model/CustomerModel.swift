//
//  CustomerModel.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 11/06/2023.
//

import Foundation

class Customer:Codable {
    var id:Int?
    var firstName:String?
    var lastName:String?
    var email:String?
    var favId:String?
    var phone:String?
    var addresses : [Address]?
    var cartId:String?
    var default_address:Address?
    init(id: Int? = nil, first_name: String? = nil, last_name: String? = nil, email: String? = nil, note: String? = nil, phone: String? = nil, addresses: [Address]? = nil, tags: String? = nil,adress:Address? = nil) {
           self.id = id
           self.firstName = first_name
           self.lastName = last_name
           self.email = email
           self.favId = note
           self.phone = phone
           self.addresses = addresses
           self.cartId = tags
           self.default_address = adress
       }
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case favId = "note"
        case phone
        case addresses
        case cartId = "tags"
        case default_address
    }
}

class CustomerModel : Codable {
    var customer:Customer?
    
    static func getCustomer(user:FUser)->CustomerModel{
        let customer = Customer(id: Int(user.objectId),first_name: user.fullname,email: user.email, phone: user.fullNumber)
        return CustomerModel(customer: customer)
    }
    static func getCustomer(user:FUser, favID: Int, cartID:Int)->CustomerModel{
        let customer = Customer(id: Int(user.objectId),first_name: user.fullname,email: user.email,note: String(favID), phone: user.fullNumber , tags: String(cartID))
        return CustomerModel(customer: customer)
    }
    init(customer: Customer?) {
         self.customer = customer
     }
    
    
}

class SearchCustomerModel : Codable {
    var customers:[Customer]?
}
