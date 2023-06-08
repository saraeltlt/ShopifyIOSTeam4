//
//  NetworkManegerProtocol.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 07/06/2023.
//

import Foundation

protocol NetworkManegerProtocol{
    func getApiData<T: Decodable>(url: String, completionHandler: @escaping (Result<T, Error>) -> Void)
    func getCurrency(amount: Float, completionHandler: @escaping (String) -> Void)
}
