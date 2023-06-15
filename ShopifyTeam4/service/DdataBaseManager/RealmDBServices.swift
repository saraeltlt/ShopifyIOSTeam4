//
//  RealmDBServices.swift
//  ShopifyTeam4
//
//  Created by Youssef Mohamed on 15/06/2023.
//
import Foundation
import RealmSwift
class RealmDBServices{
    static let instance = RealmDBServices()
    private var realmFileReference:Realm?
    private init() {}
    func initRealmFile(complitionHandler : @escaping(_ errorMessage:String?) -> ()){
        do{
            realmFileReference = try Realm()
            complitionHandler(nil)
        }catch {
            complitionHandler(error.localizedDescription)
        }
    }
    func addProduct(product:ProductFavorite,complitionHandler : @escaping(_ errorMessage:String?) -> ()){
        initRealmFile { errorMessage in
            if let errorMessage = errorMessage{
                complitionHandler(errorMessage)
            }else{
                do{
                    try self.realmFileReference!.write {
                        self.realmFileReference?.add(product)
                        complitionHandler(nil)
                    }
                }catch {
                    complitionHandler(error.localizedDescription)
                }
            }
        }
    }
    func getAllFavoriteItems(complitionHandler : @escaping(_ errorMessage:String?,_ favoriteProducts:[ProductFavorite]?) -> ()){
        initRealmFile { errorMessage in
            if let errorMessage = errorMessage{
                complitionHandler(errorMessage,nil)
            }else{
                let results = self.realmFileReference?.objects(ProductFavorite.self)
                var products:[ProductFavorite] = []
                if let results = results {
                    if results.count > 0{
                        for i in 0...results.count - 1{
                            products.append(
                                ProductFavorite(id: results[i].id,
                                                name:results[i].name,
                                                image:results[i].image)
                            )
                        }
                    }
                }
                complitionHandler(nil,products)
            }
        }
    }
    func deleteAllFavorite(complitionHandler : @escaping(_ errorMessage:String?) -> ()){
        initRealmFile { errorMessage in
            if let errorMessage = errorMessage{
                complitionHandler(errorMessage)
            }else{
                let results = self.realmFileReference?.objects(ProductFavorite.self)
                if let results = results{
                    do{
                        try self.realmFileReference!.write {
                            self.realmFileReference?.delete(results)
                            complitionHandler(nil)
                        }
                    }catch {
                        complitionHandler(error.localizedDescription)
                    }
                }
             complitionHandler(nil)
            }
        }
    }
    func deleteItemById(id:Int,complitionHandler : @escaping(_ errorMessage:String?) -> ()){
            initRealmFile { errorMessage in
                if let errorMessage = errorMessage{
                    complitionHandler(errorMessage)
                }else{
                    let results = self.realmFileReference?.objects(ProductFavorite.self)
                    if let results = results{
                        do{
                            let item = results.filter("id = \(id)")
                            try self.realmFileReference!.write {
                                self.realmFileReference?.delete(item)
                            }
                            complitionHandler(nil)
                        }catch {
                        complitionHandler(error.localizedDescription)
                            }
                        }
                    complitionHandler(nil)
                }
            }
        }
}
