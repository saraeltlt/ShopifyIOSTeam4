//
//  Mockable.swift
//  ShopifyTeam4Tests
//
//  Created by Sara Eltlt on 20/06/2023.
//

/*
 test user
 Id -> 7023980937501
 email -> testUser22s@gmail.com
 password -> testUser22s@gmail.com
phone-> 01256854138
 address -> 9279432491293
 draftOrder->1116324626717
 */

import Foundation
protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJSON<T: Decodable>(filename: String, type: T.Type) throws -> T
}

extension Mockable {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    func loadJSON<T: Decodable>(filename: String, type: T.Type) throws -> T {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            throw MockableError.failedToLoadJSON
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
        } catch {
            throw MockableError.failedToDecodeJSON
        }
    }
}

enum MockableError: Error {
    case failedToLoadJSON
    case failedToDecodeJSON
}
