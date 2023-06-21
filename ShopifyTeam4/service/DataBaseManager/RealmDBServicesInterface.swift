//
//  RealmDBServicesInterface.swift
//  ShopifyTeam4
//
//  Created by Youssef Mohamed on 21/06/2023.
//

import Foundation
import RealmSwift

protocol RealmDBServicesInterface{
   func initRealmFile(complitionHandler: @escaping(_ errorMessage:String?) -> ())

   func addProduct(product: ProductFavorite, completionHandler: @escaping (_ errorMessage: String?) -> ())

   func getProductsCount(ofType type: ProductFavorite.Type, completionHandler: @escaping (_ errorMessage: String?, _ productsCount: Int?) -> ())

   func deleteAllProducts(ofType type: ProductFavorite.Type, completionHandler: @escaping (_ errorMessage: String?) -> ())
    
   func deleteProductById(ofType type: ProductFavorite.Type, id: Int, completionHandler: @escaping (_ errorMessage: String?) -> ())

   func getIDsOfAllFavoriteItems(complitionHandler: @escaping(_ errorMessage:String?,_ idsOfFavoriteItems: [Int]?) -> () )
}
