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
    enum COUPONS: String {
        case save15 = "Save15%"
        case save50 = "Save50%"
        case saveLimited80 = "SaveLimited80%"
    }
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
    static let COUPON_IMAGE = "coupon"
    static let WARNINNG_IMAGE = "warning"
    static let SUCCESS_IMAGE = "success"
    static let ADDRESS_IMAGE = "address"
    
    //API KEY
    static let CUREENCY_API_KEY = "f4c224feba0e40fc88ccfb7f26fbd189"
    static let MARCHANT_ID = "merchant.com.pushpendra.pay"
    
    
    //user id
    static var USER_ID = 0
    static var FAV_ID = 0
    static var CART_ID = 0
    
    //stored favorite products array
    static var idsOfFavoriteProducts:[Int] = []
    
}

