//
//  getAPiDataTests.swift
//  ShopifyTeam4Tests
//
//  Created by Sara Eltlt on 19/06/2023.
//

import XCTest
import Alamofire
@testable import ShopifyTeam4

final class getAPiDataTests: XCTestCase {
    
    
    var networkManager : NetworkManegerProtocol!


    override func setUpWithError() throws {
        networkManager = NetworkManager.shared
    }

    override func tearDownWithError() throws {
        super.tearDown()
        networkManager = nil
    }
    
    //MARK: - test get api data
    
    func testGetApiData_Success() {
           // Given
           let expectation = expectation(description: "API data retrieval")
           let url = URLs.shared.allProductsURL()
           
           // When
        networkManager.getApiData(url: url) { (result: Result<BrandProductsModel, Error>) in
               // Then
               switch result {
               case .success(let data):
                   XCTAssertNotNil(data)
                   expectation.fulfill()
               case .failure(let error):
                   XCTFail("Error: \(error.localizedDescription)")
               }
           }
           
           waitForExpectations(timeout: 5.0)
       }
    
    func testGetApiData_Failure_InvalidURL() {
           // Given
           let expectation = expectation(description: "API data retrieval")
           let invalidURL = "https://invalid-url.com"
           
           // When
        networkManager.getApiData(url: invalidURL) { (result: Result<BrandProductsModel, Error>) in
               // Then
               switch result {
               case .success:
                   XCTFail("Expected failure, but received success.")
               case .failure(let error):
                   XCTAssertNotNil(error)
                   expectation.fulfill()
               }
           }
           
           waitForExpectations(timeout: 5.0)
       }
    
    //MARK: - test get currency
    func testGetCurrency_Success() {
    }
    
    
  
          


}
