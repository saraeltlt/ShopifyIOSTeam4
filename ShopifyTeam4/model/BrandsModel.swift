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
}

struct Image: Codable {
    let src: String?
}
