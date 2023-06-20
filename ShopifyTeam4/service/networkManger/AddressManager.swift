//
//  AddressManager.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 11/06/2023.
//

import Foundation
import Alamofire


extension NetworkManager {
     func createNewAddress(url: String , address:Address, completion:@escaping(Result<responseAddress,Error>) -> Void){
         
        let headers: HTTPHeaders = [
            "X-Shopify-Access-Token" : "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",
            "Content-Type" : "application/json"
        ]
        
        let customerAddress = PostAddress(address: address)
        let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
        guard let jsonData = try? encoder.encode(customerAddress) else{
            print ("ERORRRR encoding")
            return
        }
        AF.upload(jsonData , to: url, method: .post, headers: headers)
            .validate()
            .responseDecodable(of: responseAddress.self){ response in
                switch response.result{
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
                
            }
        
    }
    
}
