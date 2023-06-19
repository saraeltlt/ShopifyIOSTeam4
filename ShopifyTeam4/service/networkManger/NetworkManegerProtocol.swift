//
//  NetworkManegerProtocol.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 07/06/2023.
//

import Foundation

protocol NetworkManegerProtocol{
    
    func getApiData<T: Decodable>(url: String, completionHandler: @escaping (Result<T, Error>) -> Void)
    func editApiData<T>(method: String, url: String, completion: @escaping (Result<T, Error>) -> Void)
    func addNewCustomer(method: String,url:String,Newcustomer: CustomerModel,complication:@escaping (CustomerModel?) -> Void)
    func createNewAddress(url: String , address:Address, completion:@escaping(Result<responseAddress,Error>) -> Void)
    func createOrder(url:String,order:PostOrderModel,completion: @escaping (Data?,URLResponse?,Error?)->Void)
    func addDraftOrder(method:String, url:String, order:DraftOrderModel, completion: @escaping (Result<DraftOrderModel, Error>) -> Void)
    func getCurrency(completionHandler: @escaping (Double) -> Void)
}
