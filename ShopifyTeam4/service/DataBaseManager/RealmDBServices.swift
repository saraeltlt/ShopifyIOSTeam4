//
//  RealmDBServices.swift
//  ShopifyTeam4
//
//  Created by Youssef Mohamed on 15/06/2023.
//
import Foundation
import RealmSwift


class RealmDBServices:RealmDBServicesInterface{
    static var instance = RealmDBServices()
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
    
    func addProduct<T: Object>(product: T, completionHandler: @escaping (_ errorMessage: String?) -> ()) {
        initRealmFile { errorMessage in
            if let errorMessage = errorMessage {
                completionHandler(errorMessage)
            } else {
                do {
                    guard let primaryKeyValue = product.value(forKey: "id") as? Int else {
                        completionHandler("Product primary key not found")
                        return
                    }
                    
                    if self.realmFileReference?.object(ofType: T.self, forPrimaryKey: primaryKeyValue) != nil {
                        let errorMessage = "Product already exists"
                        completionHandler(errorMessage)
                    } else {
                        try self.realmFileReference?.write {
                            self.realmFileReference?.add(product)
                            completionHandler(nil)
                        }
                    }
                } catch {
                    completionHandler(error.localizedDescription)
                }
            }
        }
    }
    
    
    func getAllProducts<T: Object>(ofType type: T.Type,completionHandler: @escaping (_ errorMessage: String?, _ products: Results<T>?) -> ()) {
        initRealmFile { errorMessage in
            if let errorMessage = errorMessage {
                completionHandler(errorMessage, nil)
            } else {
                let results = self.realmFileReference?.objects(type)
                if let results = results {
                    completionHandler(nil, results)
                }
                
            }
        }
    }
    
    
    func getProductsCount<T: Object>(ofType type: T.Type,completionHandler: @escaping (_ errorMessage: String?, _ productsCount: Int?) -> ()) {
        initRealmFile { errorMessage in
            if let errorMessage = errorMessage {
                completionHandler(errorMessage, nil)
            } else {
                let results = self.realmFileReference?.objects(type).count
                if let results = results {
                    completionHandler(nil, results)
                }
                
            }
        }
    }
    
    
    func deleteAllProducts<T: Object>(ofType type: T.Type, completionHandler: @escaping (_ errorMessage: String?) -> ()) {
        initRealmFile { errorMessage in
            if let errorMessage = errorMessage {
                completionHandler(errorMessage)
            } else {
                let results = self.realmFileReference?.objects(type)
                if let results = results {
                    do {
                        try self.realmFileReference?.write {
                            self.realmFileReference?.delete(results)
                            completionHandler(nil)
                        }
                    } catch {
                        completionHandler(error.localizedDescription)
                    }
                }
                completionHandler(nil)
            }
        }
    }
    func deleteProductById<T: Object>(ofType type: T.Type, id: Int, completionHandler: @escaping (_ errorMessage: String?) -> ()) {
        initRealmFile { errorMessage in
            if let errorMessage = errorMessage {
                completionHandler(errorMessage)
            } else {
                let results = self.realmFileReference?.objects(type)
                if let results = results {
                    do {
                        print("results before deletion \(results)")
                        let item = results.filter("id = \(id)")
                        try self.realmFileReference?.write {
                            self.realmFileReference?.delete(item)
                        }
                        print("results after deletion \(results)")
                        completionHandler(nil)
                    } catch {
                        completionHandler(error.localizedDescription)
                    }
                }
            }
        }
    }
    

    
    func updateProductCart(id: Int, count:Int, completionHandler: @escaping (_ error: String?) -> ()) {
            initRealmFile { errorMessage in
                if let errorMessage = errorMessage {
                    completionHandler(errorMessage)
                } else {
                    let results = self.realmFileReference?.objects(ProductCart.self).filter("id = \(id)")
                    if let product = results?.first {
                        do {
                            try self.realmFileReference?.write {
                                product.ItemCount = count
                                completionHandler(String(product.ItemCount))
                            }
                        } catch {
                            completionHandler(error.localizedDescription)
                        }
                    } else {
                        completionHandler(nil)
                    }
                }
            }
        }
    func getIDsOfAllFavoriteItems(complitionHandler : @escaping(_ errorMessage:String?,_ idsOfFavoriteItems:[Int]?) -> ()){
        initRealmFile { errorMessage in
            if let errorMessage = errorMessage{
                complitionHandler(errorMessage,nil)
            }else{
                let results = self.realmFileReference?.objects(ProductFavorite.self)
                var idsArray:[Int] = []
                if let results = results {
                    if results.count > 0{
                        for i in 0...results.count - 1{
                            idsArray.append(results[i].id)
                        }
                    }
                }
                print("number of ids favorite items is : \(idsArray.count)")
                complitionHandler(nil,idsArray)
            }
        }
    }
}

