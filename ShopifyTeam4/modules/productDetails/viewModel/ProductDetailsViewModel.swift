//
//  ProductDetailsViewModel.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 11/06/2023.
//

import Foundation

class ProductDetailsViewModel{
    var productId:Int
    var endPoint = ""
    var productDetails:ProductDetails?
    let urlClassInstance = URLs.shared
    let networkManagerInstance = NetworkManager.shared
    var successClosure:(ProductDetails) -> () = {_ in }
    var failClosure:(String) -> () = {_ in}
    init(productId: Int) {
        self.productId = productId
        print(productId)
        endPoint = urlClassInstance.getProductDetails(productId: productId)
    }
    func getProductDetails(){
        print("here inside mrthof")
        networkManagerInstance.getApiData(url: endPoint) { [weak self] (result: Result<ProductDetailsModel, Error>) in
            guard let self = self else {return}
            switch result {
            case .success(let productResponse):
                productDetails = ProductDetails(brand: productResponse.product!)
                self.successClosure(productDetails!)
                print(productResponse.product?.title ?? "title is nil ..!")
            case .failure(let error):
                self.failClosure(error.localizedDescription)
                print(error.localizedDescription)
            }
        }
    }
}
