//
//  HomeViewModel.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 07/06/2023.
//

import Foundation
import UIKit
import Network
class HomeViewModel{
    var brands:Observable<Bool>=Observable(false)
    var favoritesCount:Observable<Int>=Observable(0)
    var CartItemsCount:Observable<Int>=Observable(0)
    var brandsArray  = [Product]()
    var backupBrandsArray  = [Product]()
    var advertesmentsArray:[UIImage]=[UIImage(named: "ads3")!,UIImage(named: "ads2")!,UIImage(named: "ads1")!]
    let realmDBServiceInstance = RealmDBServices.instance
    
    func getBrandsData(){
        let url = URLs.shared.getBrandsURL()
                
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
    
    
    func getAllSotredFavoriteItems(){
        realmDBServiceInstance.getProductsCount(ofType: ProductFavorite.self) { [weak self] errorMessage, productsCount in
                guard let self = self else {return}
                if let errorMessage = errorMessage{
                    print(errorMessage)
                }else{
                    if let productsCount = productsCount{
                        self.favoritesCount.value = productsCount
                    }
                }
            }
        }
    
    
    func getAllSotredShoppingCardItems(){
        realmDBServiceInstance.getProductsCount(ofType: ProductCart.self) { [weak self] errorMessage, productsCount in
                guard let self = self else {return}
                if let errorMessage = errorMessage{
                    print(errorMessage)
                }else{
                    if let productsCount = productsCount{
                        self.CartItemsCount.value = productsCount
                    }
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
        K.idsOfFavoriteProducts=[]
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
