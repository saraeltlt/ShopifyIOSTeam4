//
//  CustomerManager.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 11/06/2023.
//

import Foundation

extension NetworkManager {
    func addNewCustomer(method: String, url: String, newCustomer: CustomerModel, completion: @escaping (Result<CustomerModel, Error>) -> Void) {
        guard let url = URL(string: url) else {
            let error = NSError(domain: "InvalidURL", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.httpShouldHandleCookies = false
        
        do {
            let encoder = JSONEncoder()
            let customerData = try encoder.encode(newCustomer)
            let customerDictionary = try JSONSerialization.jsonObject(with: customerData, options: []) as? [String: Any] ?? [:]
            let bodyData = try JSONSerialization.data(withJSONObject: customerDictionary, options: .prettyPrinted)
            urlRequest.httpBody = bodyData
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    let unknownError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown response"])
                    completion(.failure(unknownError))
                    return
                }
                
                if let data = data, let jsonResponse = try? JSONDecoder().decode(CustomerModel.self, from: data) {
                    if 200..<300 ~= httpResponse.statusCode {
                        completion(.success(jsonResponse))
                    } else {
                        let statusCodeError = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP status code: \(httpResponse.statusCode)"])
                        completion(.failure(statusCodeError))
                    }
                } else {
                    let parsingError = NSError(domain: "ParsingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse customer data"])
                    completion(.failure(parsingError))
                }
            }.resume()
        } catch let error {
            completion(.failure(error))
        }
    }
}
