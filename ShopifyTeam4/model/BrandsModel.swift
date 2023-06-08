//
//  BrandsModel.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 07/06/2023.
//

import Foundation

//smart_collections


struct BrandsModel: Codable {
    let smartCollections: [Brand]?
    
    enum CodingKeys: String, CodingKey {
        case smartCollections = "smart_collections"
    }
}
struct Brand: Codable{
    let id: Int?
    let title: String?
    let image: Image?
    let variants : [Variant]?
    let product_type : String?
}

struct Image: Codable {
    let src: String?
}

struct Variant: Codable {
    let price : String?
}
