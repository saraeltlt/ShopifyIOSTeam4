//
//  AddressModel.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 11/06/2023.
//

import Foundation

class Address: Codable {
    var id : Int?
    var address1, city, country, phone: String?
    var isDefault:Bool = false
    
    enum CodingKeys: String, CodingKey {
          case id
          case address1
          case city
          case country
          case phone
          case isDefault = "default"
      }
    init(id: Int? = nil, address1: String? = nil, city: String? = nil, country: String? = nil, phone: String? = nil, isDefault: Bool = false) {
          self.id = id
          self.address1 = address1
          self.city = city
          self.country = country
          self.phone = phone
          self.isDefault = isDefault
      }
}

class CustomerAddress: Codable {
    var addresses: [Address]?
    init(addresses: [Address]?) {
           self.addresses = addresses
       }
}
struct PostAddress: Codable {
    let address: Address?
}

struct responseAddress: Codable {
    let customer_address: Address?
}

