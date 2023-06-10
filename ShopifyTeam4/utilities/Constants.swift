//
//  Constants.swift
//  Shopify_team4
//
//  Created by Sara Eltlt on 03/06/2023.
//

import Foundation
struct K {
    static var CURRENCY: String = "USD"
    static var DEFAULT_ADDRESS: String = "Alex"
    static let APPERANCE_MODE_KEY = "AppearanceMode"
    static var EXCHANGE_RATE = 30.94
    //cells id
    static let ADS_CELL = "AdvertisementsViewCell"
    static let BRANDS_CELL = "BrandViewCell"
    static let ORDERS_CELL = "OrdersCell"
    static let SETTINGS_CELL = "SettingsCell"
    static let ADDRESS_CELL = "addressCell"
    static let CART_CELL = "ShoppingCartCell"
    static let CATEGORY_CELL =  "CategoryViewCell"
    
    //colors
    static let ORANGE = "orange"
    static let LIGHT_ORANGE = "lightOrange"
    static let PAIGE = "paige"
    static let GREEN = "green"
    static let LIGHT_GREEN = "lightGreen"
    
    //images
    static let CART_IMAGE = "cart"
    static let MEN = "men"
    static let WOMEN = "women"
    static let KIDS = "kids"
    static let SALE = "sale"
    static let ACCESSORISE = "accessorise"
    static let TSHIRT = "shirt"
    static let SHOES = "shoes"
    
    //API KEY
    static let CUREENCY_API_KEY = "f4c224feba0e40fc88ccfb7f26fbd189"
    static let MARCHANT_ID = "merchant.com.pushpendra.pay"
   

}
struct URLs{
    
    static let shared = URLs()
    private init(){}

    let baseURL = "https://d097bbce1fd2720f1d64ced55f0e485b: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@mad43-alex-ios-team4.myshopify.com/admin/api/2023-04/"
    
    func allProductsURL() -> String{
        return baseURL + "products.json"
    }
    
    func categoryProductsURL(id : Int) -> String{
        return baseURL + "products.json?collection_id=\(id)"
    }
    
    
    func customersURl()->String {
        return baseURL + "customers.json"
    }
  
    func addAddress(id: Int) -> String {
        return  baseURL + "customers/\(id).json"
    }
    func getAllAddress(id: Int) -> String {
        return baseURL 
    }
    
    func setDefaultAddress(customerID: Int, addressID: Int) -> String{
        return baseURL + "customers/\(customerID)/addresses/\(addressID)/default.json"
    }
    func deleteOrEditAddress (customerID: Int, addressID: Int) -> String{
        return baseURL + "customers/\(customerID)/addresses/\(addressID).json"
    }
    
}
