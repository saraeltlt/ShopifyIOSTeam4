//
//  ShoppingCartViewModel.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 10/06/2023.
//

import Foundation
class ShoppingCartViewModel{
    var calcSubTotalObservable:Observable<Bool>=Observable(false)
    var subTotal: Double = 0.0
    var cartArray  = [Product]() //change type
    
    
    func calculateSubTotal(){
        //loop on all realm array product and sum prices
        subTotal+=1
        calcSubTotalObservable.value=true
    }
    
    
    
}
