//
//  PaymentViewModel.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 11/06/2023.
//

import Foundation
import PassKit
class PaymentViewModel{
    var subTotal = 0.0
    var discount = 0.0
    var shippingFees = 2.0 //USD
    var total = 0.0
      var paymentRequest : PKPaymentRequest = {
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
          request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Shopify", amount: NSDecimalNumber(value: 100 ))]
        return request
    }()
    
    
    func postOrder(){
        // Create an Address object
        let address = Address(id: 1, address1: "123 Main St", city: "New York", country: "USA", phone: "555-1234", isDefault: true)
        
        // Create an array of addresses
        let addresses = [address]
        
        // Create a Customer object
        let customer = Customer(id: 7010272051485, first_name: "John", last_name: "Doe", email: "sarsor@gmail.com", note: "Some note", phone: "+201206425318", addresses: addresses)
        
        // Create an OrderProduct object
        let orderProduct = OrderProduct(variant_id: 66, quantity: 4, name: "SARSOR PRODUCT", price: .double(99), title: "SARSOR PRODUCT")
        
        // Create an array of OrderProduct objects
        let lineItems = [orderProduct]
        
        // Create an Order object
        
        let order = Order(id: 53, customer: customer, line_items: lineItems, created_at: "2023-04-10", financial_status: "paid", current_total_price: "$19.98")
        // Create an OrderModel object
        let orderModel = PostOrderModel(order: order)
        
        //delete shpping cart realm
        NetworkManager.createOrder(order: orderModel) { data, response, error in
            print("addeds successfully to sarver")
            print(data)
            print(response)
        }
    }
    
    
    
    
}
