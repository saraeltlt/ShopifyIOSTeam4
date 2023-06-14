//
//  URLs.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 10/06/2023.
//

import Foundation

struct URLs{
    
    static let shared = URLs()
    private init(){}

    let baseURL = "https://d097bbce1fd2720f1d64ced55f0e485b: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@mad43-alex-ios-team4.myshopify.com/admin/api/2023-04/"
    
    
    //products
    func allProductsURL() -> String{
        return baseURL + "products.json"
    }
    
    func getProductDetails(productId:Int)-> String{
        return baseURL + "products/\(productId).json"
        
    }

    func categoryProductsURL(id : Int) -> String{
        return baseURL + "products.json?collection_id=\(id)"
    }
    
    //Customer
    func customersURl()->String {
        return baseURL + "customers.json"
    }
    func searchForCustomer(email:String)->String{
        return baseURL + "customers/search.json?query=email:\(email)"
    }
    
    //Address
  
    func addAddress(id: Int) -> String {
        return  baseURL + "customers/\(id)/addresses.json"
    }
    
    func getAllAddress(id: Int) -> String {
        return baseURL + "customers/\(id)/addresses.json"
    }
    func setDefaultAddress(customerID: Int, addressID: Int) -> String{
        return baseURL + "customers/\(customerID)/addresses/\(addressID)/default.json"
    }
    func deleteOrEditAddress (customerID: Int, addressID: Int) -> String{
        return baseURL + "customers/\(customerID)/addresses/\(addressID).json"
    }
    
    // orders
    
    func postOrder()->String{
        return baseURL + "orders.json"
    }
    
    func getOrders(customerId:Int)->String{
        return baseURL + "customers/\(customerId)/orders.json"
    }
    func postDraftOrder() -> String{
        return baseURL + "draft_orders.json"
    }
    
    func putDraftOrder(draftOrderId : Int) -> String{
        return baseURL + "draft_orders/\(draftOrderId).json"
        
    }
 
    

    
}
