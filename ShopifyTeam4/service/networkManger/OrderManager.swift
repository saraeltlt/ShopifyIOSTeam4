//
//  OrderManager.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 12/06/2023.
//

import Foundation

extension NetworkManager {
    static  func createOrder(order:PostOrderModel,completion: @escaping (Data?,URLResponse?,Error?)->Void){
        let url = URL(string: "https://d097bbce1fd2720f1d64ced55f0e485b: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@mad43-alex-ios-team4.myshopify.com/admin/api/2023-04/orders.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
        session.dataTask(with: request) { (data,response,error) in
            completion(data, response, error)
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
