//
//  CheckoutViewModel.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 15/06/2023.
//

import Foundation
class CheckoutViewModel{
    var defaultAddress: Address
    var subTotal:Double
    
    init (defaultAddress: Address, subTotal:Double ){
        self.defaultAddress = defaultAddress
        self.subTotal = subTotal
    }
    
    func configNavigation(total : Double) -> PaymentViewModel{
        return PaymentViewModel(defaultAddreaa: defaultAddress, total: total)
    }
    
    
}
