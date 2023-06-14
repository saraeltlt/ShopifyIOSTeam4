//
//  BrandsModel.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 07/06/2023.
//

import Foundation




class BrandsModel: Codable {
    let smartCollections: [Brand]?
    
    enum CodingKeys: String, CodingKey {
        case smartCollections = "smart_collections"
    }
    
    init(smartCollections: [Brand]?) {
           self.smartCollections = smartCollections
       }
}
class Brand: Codable{
    let id: Int?
    let title: String?
    let image: Image?
    let images:[Image]?
    let variants : [Variant]?
    let product_type : String?
    let body_html : String?
    
    init(id: Int?, title: String?, image: Image?, images: [Image]?, variants: [Variant]?, product_type: String?, body_html: String?) {
           self.id = id
           self.title = title
           self.image = image
           self.images = images
           self.variants = variants
           self.product_type = product_type
           self.body_html = body_html
       }
}

class ProductDetailsModel:Codable{
    var product:Brand?
    init(product: Brand?) {
           self.product = product
       }
}
// viewObject productDetails
class ProductDetails{
    let name: String
    var price: String
    let description : String
    var imagesArray : [String]
    init(brand:Brand){
        name = brand.title ?? "no name"
        price = brand.variants?.first?.price ?? "no price"
        if (K.CURRENCY == "USD"){
            price = "\(price) USD"
        } else {
            let result = Int(Double(price)! * K.EXCHANGE_RATE)
            price = "\(result) EGP"
        }
        description = brand.body_html ?? "no description"
        imagesArray = []
        for image in brand.images ?? [] {
            imagesArray.append(image.src!)
        }
    }
}
class Image: Codable{
    let src: String?
    init(src: String?) {
           self.src = src
       }
}

class Variant: Codable {
    let price : String?
    init(price: String?) {
            self.price = price
        }
}
