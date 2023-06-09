//
//  NetworkManager.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 07/06/2023.
//
//NetworkManager
import Foundation


import Foundation
import Alamofire

class NetworkManager : NetworkManegerProtocol{
    
    static let shared = NetworkManager()
        
    private init() {}
    
    func getApiData<T: Decodable>(url: String, completionHandler: @escaping (Result<T, Error>) -> Void) {
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(T.self, from: data!)
                    completionHandler(.success(jsonData))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getCurrency(completionHandler: @escaping (Double) -> Void) {
        let apiURL = "https://openexchangerates.org/api/latest.json"
        let apiKey = K.CUREENCY_API_KEY
        let baseCurrency = "USD"
        let targetCurrency = "EGP"
        
        let parameters: Parameters = [
            "app_id": apiKey,
            "base": baseCurrency,
            "symbols": targetCurrency
        ]
        
        AF.request(apiURL, parameters: parameters).responseJSON { response in
            var result = 0.0 // Default result
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any],
                   let rates = json["rates"] as? [String: Double],
                   let exchangeRate = rates[targetCurrency] {
                    result = exchangeRate
                }
            case .failure(let error):
                print("Failed to retrieve currency data: \(error)")
            }
            
            completionHandler(result)
        }
    }
    
    

}
