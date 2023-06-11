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
    
    
    
    
    
    
    
}
