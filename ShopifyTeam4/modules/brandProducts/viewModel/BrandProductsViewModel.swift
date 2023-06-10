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
    var brandProductsArray  = [Brand]()
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
        return brandProductsArray.count
    }
    
    func getProductData(index:Int)->Brand{
        return brandProductsArray[index]
    }
    
    
    func configNavigation(index:Int)->ProductDetailsViewModel{
        return ProductDetailsViewModel(productId: brandProductsArray[index].id ?? 0)
    }
    
    
    
}
