//
//  CustomerManager.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 11/06/2023.
//

import Foundation

extension NetworkManager {
     func addNewCustomer(method: String,url:String,Newcustomer: CustomerModel,complication:@escaping (CustomerModel?) -> Void) {
        let url = URL(string: url)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = method
        urlRequest.httpShouldHandleCookies = false
        do {
            
            let encoder = JSONEncoder()
            let customerData = try? encoder.encode(Newcustomer)
            var customerDictionary = try? JSONSerialization.jsonObject(with: customerData!, options: []) as? [String: Any]
            let bodyData = try JSONSerialization.data(withJSONObject: customerDictionary, options: .prettyPrinted)
            urlRequest.httpBody = bodyData
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
        } catch let error {
            print(error.localizedDescription)
        }
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if (data != nil && data?.count != 0){
                if let httpResponse = response as? HTTPURLResponse {
                    let response = String(data:data!,encoding: .utf8)
                    print(response!)
                    guard let data = data else {return}
                    let jsonResponse = try? JSONDecoder().decode(CustomerModel.self, from: data)
                    print(jsonResponse!)
                    complication(jsonResponse)
                    
                }
            }
            
        }.resume()
        
    }

}
