//
//  BrandProductsModel.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 07/06/2023.
//

import Foundation

class BrandProductsModel:Codable{
    let brandProducts: [Brand]?
    
    enum CodingKeys: String, CodingKey {
        case brandProducts = "products"
    }
}
