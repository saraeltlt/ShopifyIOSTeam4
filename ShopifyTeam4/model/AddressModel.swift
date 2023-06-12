//
//  AddressModel.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 11/06/2023.
//

import Foundation

struct Address: Codable {
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
}

struct CustomerAddress: Codable {
    var addresses: [Address]?
}

