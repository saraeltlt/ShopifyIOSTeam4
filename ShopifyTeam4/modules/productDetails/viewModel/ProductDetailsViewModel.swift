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
    
    
    func AddToCart() -> String{
        let realmServices = RealmDBServices.instance
        var returnMsg:String = ""
        let product = ProductCart(id: productId, name: productDetails?.name ?? "", image: productDetails?.imagesArray[0] ?? "", price: productDetails?.price ?? "0", ItemCount: 1, quantity: productDetails?.quantity ?? 1 )
        realmServices.addProduct(product: product) { error in
            if let error = error {
                returnMsg="Error adding product: \(error)"
            } else {
                returnMsg="Product added successfully"
                
            }
        }
        return returnMsg
    }
    func addToFavorite() -> String{
        let realmServices = RealmDBServices.instance
        var returnMsg:String = ""
        let product = ProductFavorite(id: productId, name: productDetails?.name ?? "", image: productDetails?.imagesArray[0] ?? "", price: productDetails?.price ?? "0")
        realmServices.addProduct(product: product) { error in
            if let error = error {
                returnMsg="Error adding product: \(error)"
            } else {
                returnMsg="Product added successfully"
            }
        }
        return returnMsg
    }
    func removeFromFavorite() -> String{
        let realmServices = RealmDBServices.instance
        var returnMsg:String = ""
        let product = ProductFavorite(id: productId, name: productDetails?.name ?? "", image: productDetails?.imagesArray[0] ?? "", price: productDetails?.price ?? "0")
        realmServices.deleteProductById(ofType: ProductFavorite.self, id: productId) { errorMessage in
            if let error = errorMessage {
                returnMsg="Error when removing product: \(error)"
            } else {
                returnMsg="Product removed successfully"
            }
        }
        return returnMsg
    }
}
