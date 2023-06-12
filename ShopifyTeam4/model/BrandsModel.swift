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
    let images:[Image]?
    let variants : [Variant]?
    let product_type : String?
    let body_html : String?
}

struct ProductDetailsModel:Codable{
    var product:Brand?
}
// viewObject productDetails
struct ProductDetails{
    let name: String
    let price: String
    let description : String
    var imagesArray : [String]
    init(brand:Brand){
        name = brand.title ?? "no name"
        price = brand.variants?.first?.price ?? "no price"
        description = brand.body_html ?? "no description"
        imagesArray = []
        for image in brand.images ?? [] {
            imagesArray.append(image.src!)
        }
    }
}
struct Image: Codable{
    let src: String?
}

struct Variant: Codable {
    let price : String?
}
