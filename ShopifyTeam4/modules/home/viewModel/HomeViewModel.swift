//
//  HomeViewModel.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 07/06/2023.
//

import Foundation
import UIKit
class HomeViewModel{
    var brands:Observable<Bool>=Observable(false)
    var brandsArray  = [Product]()
    var backupBrandsArray  = [Product]()
    var advertesmentsArray:[UIImage]=[UIImage(named: "ads3")!,UIImage(named: "ads2")!,UIImage(named: "ads1")!]
    let realmDBServiceInstance = RealmDBServices.instance
    
    func getBrandsData(){
        let url = "https://d097bbce1fd2720f1d64ced55f0e485b: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@mad43-alex-ios-team4.myshopify.com/admin/api/2023-04/smart_collections.json"
                
                NetworkManager.shared.getApiData(url: url) { [weak self] (result: Result<BrandsModel, Error>) in
                    switch result {
                    case .success(let brands):
                        self?.brandsArray = brands.smartCollections!
                        self?.backupBrandsArray = brands.smartCollections!
                        self?.brands.value = true
                    case .failure(let error):
                        print(error)
                    }
                }
    }
    
    func getBrandsCount()->Int{
        return brandsArray.count
    }
    
    
    func getadvertesmentsCount()->Int{
        return advertesmentsArray.count
    }
    
    func getBrandData(index:Int)->Product{
        return brandsArray[index]
    }
    
    func getadvertesmentsData(index:Int)->UIImage{
        return advertesmentsArray[index]
    }
    
    func navigationConfigure(for rowIndex:Int)->BrandProductsViewModel{
        return BrandProductsViewModel(brandId: brandsArray[rowIndex].id ?? 0)
    }
    func initIdsOfFavoriteItemsArray(){
        realmDBServiceInstance.getIDsOfAllFavoriteItems { errorMessage, idsOfFavoriteItems in
            if let errorMessage = errorMessage{
                print(errorMessage)
            }else{
                K.idsOfFavoriteProducts = idsOfFavoriteItems ?? []
            }
        }
    }
    func setLoggedUserName(){
        if let user = FUser.currentUser(){
            K.USER_NAME = user.fullname 
        }
    }
}
