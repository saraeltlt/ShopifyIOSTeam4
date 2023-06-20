//
//  OrderManager.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 12/06/2023.
//

import Foundation

extension NetworkManager {
    func createOrder(url: String, order: PostOrderModel, completion: @escaping (Result<Data?, Error>) -> Void) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let session = URLSession.shared
        request.httpShouldHandleCookies = false
        
        do {
            let data = try JSONEncoder().encode(order)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            request.httpBody = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        } catch let error {
            completion(.failure(error))
            return
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let unknownError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown response"])
                completion(.failure(unknownError))
                return
            }
            
            if 200..<300 ~= httpResponse.statusCode {
                completion(.success(data))
            } else {
                let statusCodeError = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP status code: \(httpResponse.statusCode)"])
                completion(.failure(statusCodeError))
            }
        }.resume()
    }
    
    
    func addDraftOrder(method:String, url:String, order:DraftOrderModel, completion: @escaping (Result<DraftOrderModel, Error>) -> Void) {
        
        var request = URLRequest(url: URL(string:url)!)
        
        request.httpMethod = method
        let session = URLSession.shared
        request.httpShouldHandleCookies = false
        
        do {
            let data = try JSONEncoder().encode(order)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            request.httpBody = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        }catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                  var result = httpResponse.statusCode
                do {
                    let json = try JSONDecoder().decode(DraftOrderModel.self, from: data!)
                    completion(.success(json))
                } catch {
                    completion(.failure(error))
                }
                return
            }
            
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
            
            
        }.resume()
        
        
    
    }
    
}
