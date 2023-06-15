//
//  PaymentViewModel.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 11/06/2023.
//

import Foundation
import PassKit
class PaymentViewModel{
    var total = 0.0
    var defaultAddreaa: Address
    
    init (defaultAddreaa: Address, total:Double ){
        self.defaultAddreaa = defaultAddreaa
        self.total = total
    }
    func getPaymentRequest() -> PKPaymentRequest {
      let request = PKPaymentRequest()
        request.merchantIdentifier = K.MARCHANT_ID
        request.supportedNetworks = [.quicPay, .masterCard, .visa]
        request.supportedCountries = ["EG", "US"]
        request.merchantCapabilities = .capability3DS

        if K.CURRENCY == "EGP" {
            request.countryCode = "EG"
            request.currencyCode = "EGP"
     } else {
         request.countryCode = "US"
         request.currencyCode = "USD"
       }
          request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Shopify", amount: NSDecimalNumber(value: total ))]
        return request
    }
    
    
    func postOrder(){
        let addresses = [defaultAddreaa]
        let customer = Customer(id: K.USER_ID)
        let lineItems = OrderProduct.configOrderProducts(productsData: getAllShopingCartItems())
        if K.CURRENCY == "EGP" {
           total = total / K.EXCHANGE_RATE
        }
        let order = Order(id: 53, customer: customer, line_items: lineItems, created_at: "2023-04-10", financial_status: "paid", current_total_price: "\(total)")
        let orderModel = PostOrderModel(order: order)
        NetworkManager.createOrder(order: orderModel) { data, response, error in
            print("addeds successfully to sarver order")
            print(data)
            print(response)
            self.removeShoppingCartItems()
        }
    }
    
    func removeShoppingCartItems()->String{
        let realmServices = RealmDBServices.instance
        var returnMsg:String = ""
        realmServices.deleteAllProducts(ofType: ProductCart.self) { error in
            if let error = error {
                returnMsg="Error removing all items: \(error)"
                print("error remove all card product")
            } else {
                returnMsg="All products removed from card successfully"
                print(" remove cart items successfully")
                
            }
        }
      
        return returnMsg
    }
    
    func getAllShopingCartItems()->[ProductCart]{
        var cartProducts = [ProductCart]()
        let realmServices = RealmDBServices.instance
        realmServices.getAllProducts(ofType: ProductCart.self) { [weak self]error, results in
            if let error = error {
                print("Error : \(error)")
            } else {
                if let results = results {
                    if results.count > 0{
                        for i in 0...results.count - 1{
                            cartProducts.append(
                                ProductCart(id: results[i].id,
                                            name:results[i].name,
                                            image:results[i].image,
                                            price: results[i].price,
                                            ItemCount: results[i].ItemCount)
                            )
                        }
                        
                    }
                    
                }
            }
           
        }
        return cartProducts
    }
    
    
    
    
    
    
}
