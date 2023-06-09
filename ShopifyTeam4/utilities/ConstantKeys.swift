//
//  ConstantKeys.swift
//  ShopifyTeam4
//
//  Created by Youssef Mohamed on 09/06/2023.
//

import Foundation
import FirebaseDatabase

var DB = Database.database(url: "https://shopify-5fce2-default-rtdb.europe-west1.firebasedatabase.app/")
var DBref = DB.reference()
public let kOBJECTID = "objectId"
public let kFULLNAME = "fullname"
public let kEMAIL = "email"
public let kPHONE = "phone"
public let kCITY = "city"
public let kCOUNTRY = "country"
public let kSTREET = "street"
public let kCURRENTUSER = "currentUser"
