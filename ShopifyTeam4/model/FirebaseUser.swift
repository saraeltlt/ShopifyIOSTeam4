//
//  FirebaseUser.swift
//  ShopifyTeam4
//
//  Created by Youssef Mohamed on 09/06/2023.
//

import Foundation
class Fuser {
    let objectId: String
    var fullname: String
    var email: String
    var fullNumber: String
    var country: String
    var city: String
    var street: String
    //MARK: Initializers
    init(_objectId: String, _email: String, _fullname: String, _fullNumber:String, _country: String , _city: String , _street: String ) {
        objectId = _objectId
        email = _email
        fullname = _fullname
        fullNumber = _fullname
        country = _country
        city = _city
        street = _street
    }
    init(_dictionary: NSDictionary) {
        objectId = _dictionary[kOBJECTID] as! String
        
        if let mail = _dictionary[kEMAIL] {
            email = mail as! String
        } else {
            email = ""
        }
        
        if let fname = _dictionary[kFULLNAME] {
            fullname = fname as! String
        } else {
            fullname = ""
        }
        
        if let fnumber = _dictionary[kPHONE] {
            fullNumber = fnumber as! String
        } else {
            fullNumber = ""
        }
        
        if let _country = _dictionary[kCOUNTRY] {
            country = _country as! String
        } else {
            country = ""
        }
        
        if let _city = _dictionary[kCITY] {
            city = _city as! String
        } else {
            city = ""
        }
        
        if let _street = _dictionary[kSTREET] {
            street = _street as! String
        } else {
            street = ""
        }
    }
    //MARK: Returning current user funcs
//    class func currentId() -> String {
//        return Auth.auth().currentUser!.uid
//    }
//    class func currentUser () -> FUser? {
//        if Auth.auth().currentUser != nil {
//            if let dictionary = UserDefaults.standard.object(forKey: kCURRENTUSER) {
//                return FUser.init(_dictionary: dictionary as! NSDictionary)
//                }
//            }
//            return nil
//        }
}
