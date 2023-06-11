//
//  CustomerModel.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 11/06/2023.
//

import Foundation

struct Customer:Codable {
    var id:Int?
    var first_name:String?
    var last_name:String?
    var email:String?
    var note:String?
    var phone:String?
    var addresses : [Address]?
}

struct CustomerModel : Codable {
    var customer:Customer?
}

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
