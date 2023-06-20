//
//  MockNetworkManager.swift
//  ShopifyTeam4Tests
//
//  Created by Sara Eltlt on 20/06/2023.
//

import Foundation
@testable import ShopifyTeam4
class MockNetworkManager: NetworkManegerGetProtocol, Mockable {
    enum ResponseType {
        case BrandProductsModel
        case GetOrderModel
        case DraftOrderModel
        case ProductDetailsModel
        case BrandsModel
        case CustomerAddress

    }
    
    var shouldReturnError: Bool
    var responseType: ResponseType
    
    init(shouldReturnError: Bool, responseType: ResponseType) {
        self.shouldReturnError = shouldReturnError
        self.responseType = responseType
    }
    
    //MARK: - GET APi data

    func getApiData<T>(url: String, completionHandler: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        do {
            if shouldReturnError {
                let jsonData = try loadJSON(filename: "INVALID_NAME", type: BrandProductsModel.self)
                completionHandler(.success(jsonData as! T))
            } else {
                switch responseType {
                case .BrandProductsModel:
                    let jsonData = try loadJSON(filename: "BrandProductsModel", type: BrandProductsModel.self)
                    completionHandler(.success(jsonData as! T))
                    
                case .GetOrderModel:
                    let jsonData = try loadJSON(filename: "GetOrderModel", type: GetOrderModel.self)
                    completionHandler(.success(jsonData as! T))
                    
                    
                case .DraftOrderModel:
                    let jsonData = try loadJSON(filename: "DraftOrderModel", type: DraftOrderModel.self)
                    completionHandler(.success(jsonData as! T))
                    
                case .ProductDetailsModel:
                    let jsonData = try loadJSON(filename: "ProductDetailsModel", type: ProductDetailsModel.self)
                    completionHandler(.success(jsonData as! T))
                    
                    
                case .BrandsModel:
                    let jsonData = try loadJSON(filename: "BrandsModel", type: BrandsModel.self)
                    completionHandler(.success(jsonData as! T))
                    
                case .CustomerAddress:
                    let jsonData = try loadJSON(filename: "CustomerAddress", type: CustomerAddress.self)
                    completionHandler(.success(jsonData as! T))
                }
            }
        } catch MockableError.failedToDecodeJSON {
            completionHandler(.failure(MockableError.failedToDecodeJSON))
        } catch {
            completionHandler(.failure(MockableError.failedToLoadJSON))
        }
    }
    
    
    
 
    
    
}
