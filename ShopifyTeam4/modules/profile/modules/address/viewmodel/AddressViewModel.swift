//
//  AddressViewModel.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 10/06/2023.
//

import Foundation
class AddressViewModel {
    var addressArray  = [Address]()
    var gellAllAddressesObservable:Observable<Bool>=Observable(false)
    
    func getAllAddress(){
        let url = URLs.shared.getAllAddress(id: K.USER_ID)
        NetworkManager.shared.getApiData(url: url) { [weak self] (result: Result<CustomerAddress, Error>) in
            switch result {
            case .success(let data):
                print("hena 2")
                print(data.addresses)
                self?.addressArray = data.addresses ?? []
                self?.gellAllAddressesObservable.value=true
            case .failure(let error):
                print("hena 3 ERROR")
                print (error)
                
            }
        }
    }
    
    func deleteAddress(at index : Int){
        let url = URLs.shared.deleteOrEditAddress(customerID: K.USER_ID, addressID: addressArray[index].id ?? 0)
        NetworkManager.shared.editApiData(method: "DELETE", url: url, completion: {[weak self](result : Result<(Int,String),Error>) in
            switch (result){
            case .success(let status):
                print(status.0,status.1)
                self?.addressArray.remove(at: index)
                print("iam in sucess")
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
                    print("---------")
                    print("iam in sucess set as default")
                    print("---------")
                    self?.getAllAddress()
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
        
        
        
        
        
    }
    
    
    
    
    func getDefaultAddress() -> Address?{
        for item in addressArray{
            if (item.isDefault == true){
                return item
            }
        }
        return nil
    }
    
    
    
    
    
    
    
    
    
}


