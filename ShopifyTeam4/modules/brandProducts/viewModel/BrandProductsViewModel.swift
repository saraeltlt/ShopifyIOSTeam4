//
//  BrandProductsViewModel.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 07/06/2023.
//

import Foundation

class BrandProductsViewModel{
    var brandId:Int
    var products:Observable<Bool>=Observable(false)
    var brandProductsArray  = [Product]()
    var filteredProductArray = [Product]()
    var isFiltering = false
    
    init(brandId: Int) {
        self.brandId = brandId
    }
    func getBrandProducts(){
        let url = "https://d097bbce1fd2720f1d64ced55f0e485b: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@mad43-alex-ios-team4.myshopify.com/admin/api/2023-04/products.json?collection_id=\(brandId)"
                NetworkManager.shared.getApiData(url: url) { [weak self] (result: Result<BrandProductsModel, Error>) in
                    switch result {
                    case .success(let products):
                        self?.brandProductsArray = products.brandProducts!
                        self?.products.value = true
                    case .failure(let error):
                        print(error)
                    }
                }
    }
    
    func getProductsCount()->Int{
        if isFiltering {
            return filteredProductArray.count
        }else {
            return brandProductsArray.count
        }
    
    }
    
    func getProductData(index:Int)->Product{
        if isFiltering {
            return filteredProductArray[index]
        }else {
            return brandProductsArray[index]
        }
    
    }
    
    func filterProducts(price:Float){
        if price != 0.0 {
            isFiltering = true
            if K.CURRENCY == "USD" {
                filteredProductArray = brandProductsArray.filter{Float($0.variants![0].price!)! <= price}
            }else {
                filteredProductArray = brandProductsArray.filter{Float($0.variants![0].price!)!*Float(K.EXCHANGE_RATE) <= price}
            }
       
        } else {
            isFiltering = false
        }
      
    }
    
    
    
    func configNavigation(index:Int)->ProductDetailsViewModel{
        return ProductDetailsViewModel(productId: brandProductsArray[index].id ?? 0)
    }
    
    
    
}
