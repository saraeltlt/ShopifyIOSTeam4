//
//  AddressViewModel.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 10/06/2023.
//

import Foundation
class AddressViewModel {
    var addressArray  = [Address]()
    var defaultAddress : Address?
    var gellAllAddressesObservable:Observable<Bool>=Observable(false)
    var deleteObservable:Observable<Bool>=Observable(false)
    
    func getAllAddress(){
        let url = URLs.shared.getAllAddress(id: K.USER_ID)
        NetworkManager.shared.getApiData(url: url) { [weak self] (result: Result<CustomerAddress, Error>) in
            switch result {
            case .success(let data):
                self?.addressArray.removeAll()
                for address in data.addresses!{
                    if address.isDefault{
                        self?.defaultAddress = address
                    }else{
                        self?.addressArray.append(address)
                    }
                }
                self?.gellAllAddressesObservable.value=true
            case .failure(let error):
                print (error)
                
            }
        }
    }
    
    func deleteAddress(at index : Int){
   
            let url = URLs.shared.deleteOrEditAddress(customerID: K.USER_ID, addressID: addressArray[index].id ?? 0)
            NetworkManager.shared.editApiData(method: "DELETE", url: url, completion: {[weak self](result : Result<(Int,String),Error>) in
                switch (result){
                case .success(let status):
                    print ("here ->", status)
                    self?.addressArray.remove(at: index)
                    self?.gellAllAddressesObservable.value=true
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        
        
    }
    
    
    
    
    
    func  setDefaultAddress(index: Int ){
        let url = URLs.shared.setDefaultAddress(customerID: K.USER_ID, addressID: addressArray[index].id!)
        NetworkManager.shared.editApiData(method: "PUT", url: url) {[weak self](result : Result<(Int,String),Error>) in
            switch (result){
            case .success(let status):
                print(status.0,status.1)
                if (status.0 == 200){
                    self?.getAllAddress()
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
        
        
        
        
        
    }
    
    
    
    
    func getDefaultAddress() -> Address?{
        return defaultAddress
    }
    
    
    
    
    
    
    
    
    
}


