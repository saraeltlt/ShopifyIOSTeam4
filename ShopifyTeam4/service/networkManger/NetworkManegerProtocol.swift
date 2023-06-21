//
//  NetworkManegerProtocol.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 07/06/2023.
//

import Foundation

protocol NetworkManegerProtocol: NetworkManegerGetProtocol{
    
    func putOrDeleteApiData<T>(method: String, url: String, completion: @escaping (Result<T, Error>) -> Void)
    func addNewCustomer(method: String, url: String, newCustomer: CustomerModel, completion: @escaping (Result<CustomerModel, Error>) -> Void)
    func createNewAddress(url: String , address:Address, completion:@escaping(Result<responseAddress,Error>) -> Void)
    func createOrder(url: String, order: PostOrderModel, completion: @escaping (Result<Data?, Error>) -> Void)
    func addDraftOrder(method:String, url:String, order:DraftOrderModel, completion: @escaping (Result<DraftOrderModel, Error>) -> Void)
    func getCurrency(apiURL: String, completionHandler: @escaping (Result<Double, Error>) -> Void)
}

public protocol NetworkManegerGetProtocol{
    func getApiData<T: Decodable>(url: String, completionHandler: @escaping (Result<T, Error>) -> Void)

}
