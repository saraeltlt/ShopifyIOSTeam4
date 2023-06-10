//
//  AddressViewModel.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 10/06/2023.
//

import Foundation
class AddressViewModel {
   // var addressArray  = [Address]()
    
    func  setDefaultAddress(customerID: Int, addressID: Int ){
        let url = URLs.shared.setDefaultAddress(customerID: customerID, addressID: addressID)
        
    }
    
    /*func changeCategoriesIsSelectedStatus(index:Int){
        self.addressArray.forEach({ item in
            item.isDefault = false
        })
        self.addressArray[index].isDefault = true
        self.setDefaultAddress(customerID: 00, addressID: addressArray[index].id)
    }*/
    
    
    
}
