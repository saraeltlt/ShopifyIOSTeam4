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
    
    func addProduct<T: Object>(product: T, completionHandler: @escaping (_ errorMessage: String?) -> ()) {
        initRealmFile { errorMessage in
            if let errorMessage = errorMessage {
                completionHandler(errorMessage)
            } else {
                do {
                    try self.realmFileReference?.write {
                        self.realmFileReference?.add(product)
                        completionHandler(nil)
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
                        let item = results.filter("id = \(id)")
                        try self.realmFileReference?.write {
                            self.realmFileReference?.delete(item)
                        }
                        completionHandler(nil)
                    } catch {
                        completionHandler(error.localizedDescription)
                    }
                }
                completionHandler(nil)
            }
        }
    }
}

