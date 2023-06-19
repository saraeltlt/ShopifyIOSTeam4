//
//  putOrDeleteApiDataTests.swift
//  ShopifyTeam4Tests
//
//  Created by Sara Eltlt on 19/06/2023.
//

import XCTest
import Alamofire
@testable import ShopifyTeam4

final class putOrDeleteApiDataTests: XCTestCase {
    var networkManager : NetworkManegerProtocol!
    
    
    override func setUpWithError() throws {
        networkManager = NetworkManager.shared
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        networkManager = nil
    }


    func testPutOrDeleteApiData_Success(){
        let url = URLs.shared.setDefaultAddress(customerID: 7021960823069, addressID: 9278565679389)
        let expectation = self.expectation(description: "Create address request")
        networkManager.putOrDeleteApiData(method: "PUT", url: url) {[weak self](result : Result<(Int,String),Error>) in
            switch (result){
            case .success(let status):
                if (status.0 == 200){
                    XCTAssertNotNil(status)
                    expectation.fulfill()
                }else{
                    XCTFail("Request failed with error: \(status)")
                }
            case .failure(let error):
                XCTFail("Request failed with error: \(error)")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
    func testPutOrDeleteApiData_FAILED_IvalidURL(){
        let url = URLs.shared.setDefaultAddress(customerID: 0, addressID: 0)
        let expectation = self.expectation(description: "Create address request")
        networkManager.putOrDeleteApiData(method: "PUT", url: url) {[weak self](result : Result<(Int,String),Error>) in
            switch (result){
            case .success(let status):
                if (status.0 == 200){
                    XCTFail("Request failed with error: \(status)")
                
                }else{
                    XCTAssertNotNil(status)
                    expectation.fulfill()
                }
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
   

}
