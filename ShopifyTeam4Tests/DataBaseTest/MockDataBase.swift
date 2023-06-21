//
//  MockDataBase.swift
//  ShopifyTeam4Tests
//
//  Created by Youssef Mohamed on 20/06/2023.
//
@testable import ShopifyTeam4
import RealmSwift
class MockDatabase: RealmDBServicesInterface{
    
var products = [ProductFavorite]()
    func initRealmFile(complitionHandler: @escaping(_ errorMessage:String?) -> ()){
        if products.count > 0 {
            complitionHandler(nil)
        } else {
            complitionHandler("No products found")
        }
    }

    func addProduct(product: ProductFavorite, completionHandler: @escaping (_ errorMessage: String?) -> ()) {
        products.append(product)
        completionHandler(nil)
    }

    func getProductsCount(ofType type: ProductFavorite.Type, completionHandler: @escaping (_ errorMessage: String?, _ productsCount: Int?) -> ()) {
        completionHandler(nil, products.count)
    }

    func deleteAllProducts(ofType type: ProductFavorite.Type, completionHandler: @escaping (_ errorMessage: String?) -> ()) {
        products.removeAll()
        completionHandler(nil)
    }

    func deleteProductById(ofType type: ProductFavorite.Type, id: Int, completionHandler: @escaping (_ errorMessage: String?) -> ()) {
        if let product = products.first(where: { $0.id == id }) {
            products.remove(at: products.firstIndex(of: product)!)
        } else {
            completionHandler("Product not found")
        }
    }

    func getIDsOfAllFavoriteItems( complitionHandler: @escaping(_ errorMessage:String?,_ idsOfFavoriteItems: [Int]?) -> () ){
            var idsArray:[Int] = []
            if products.count > 0{
                for i in 0...products.count - 1{
                    idsArray.append(products[i].id)
                }
            }
        complitionHandler(nil, idsArray)
    }
}
