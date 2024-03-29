//
//  AddressViewModel.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 10/06/2023.
//

import Foundation
class AddressViewModel {
    var addressArray  = [Address]()
    var defaultAddress = Address()
    var gellAllAddressesObservable:Observable<Bool>=Observable(false)
    var deleteObservable:Observable<Bool>=Observable(false)
    var navigationFlag = true
    var subTotal: Double = 0.0
    
    init (navigationFlag: Bool = true, subTotal: Double = 0.0){
        self.navigationFlag=navigationFlag
        self.subTotal=subTotal
    }
    func configNavigation() -> CheckoutViewModel{
        return CheckoutViewModel(defaultAddress: defaultAddress, subTotal: subTotal)
    }
    func getAllAddress(){
        let url = URLs.shared.getAllAddress(id: K.USER_ID)
        NetworkManager.shared.getApiData(url: url) { [weak self] (result: Result<CustomerAddress, Error>) in
            switch result {
            case .success(let data):
                self?.addressArray.removeAll()
                for address in data.addresses!{
                    if address.isDefault{
                        self?.defaultAddress = address
                        K.DEFAULT_ADDRESS = "\(address.city!) - \(address.country!)"
                        UserDefaults.DefaultAddress=K.DEFAULT_ADDRESS
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
            NetworkManager.shared.putOrDeleteApiData(method: "DELETE", url: url, completion: {[weak self](result : Result<(Int,String),Error>) in
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
        self.gellAllAddressesObservable.value=false
        let url = URLs.shared.setDefaultAddress(customerID: K.USER_ID, addressID: addressArray[index].id!)
        NetworkManager.shared.putOrDeleteApiData(method: "PUT", url: url) {[weak self](result : Result<(Int,String),Error>) in
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


