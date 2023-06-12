//
//  Number.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 12/06/2023.
//

import Foundation

public enum Number: Codable {
    case integer(Int)
    case double(Double)
    case string(String)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        
        throw DecodingError.typeMismatch(Number.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Number"))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        }
    }
    
    func stringValue() -> String {
        switch self {
        case .integer(let value):
            return "\(value)"
        case .string(let value):
            return value
        case .double(let value):
            return "\(value)"
        }
    }
    
    func intValue() -> Int {
        switch self {
        case .integer(let value):
            return value
        case .string(let value):
            return Int(value) ?? 0
        case .double(let value):
            return Int(value)
        }
    }
    
    func doubleValue() -> Double {
        switch self {
        case .integer(let value):
            return Double(value)
        case .string(let value):
            return Double(value) ?? 0
        case .double(let value):
            return value
        }
    }
}
