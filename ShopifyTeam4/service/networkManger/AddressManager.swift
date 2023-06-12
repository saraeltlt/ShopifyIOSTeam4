//
//  AddressManager.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 11/06/2023.
//

import Foundation


extension NetworkManager {
    func addNewAddress(url: String ,newAddress: Address, completion: @escaping (Result<Int, Error>) -> Void) {
        let url = URL(string: url)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpShouldHandleCookies = false
        
        let userDictionary = [
            "customer_address": [
                "address1": newAddress.address1 ?? "",
                "city": newAddress.city ?? "",
                "country": newAddress.country ?? "",
                "phone": newAddress.phone ?? "",
                "country_name": newAddress.country ?? "",
                "default": newAddress.isDefault
            ]
        ]
        do {
            let bodyData = try JSONSerialization.data(withJSONObject: userDictionary, options: .prettyPrinted)
            urlRequest.httpBody = bodyData
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch let error {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                guard let data = data else {
                    
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                    return
                }
                
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let address = jsonResponse["customer_address"] as? [String: Any],
                       let addressID = address["id"] as? Int {
                        completion(.success(addressID))
                        // should return 201 if success
                    } else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: String(data:data,encoding: .utf8)!])))
                    }
                } catch {
                    completion(.failure(error))
                }
                
                return
            }
            
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: String(data:data!,encoding: .utf8)!])))
        }.resume()
    }
    
}
