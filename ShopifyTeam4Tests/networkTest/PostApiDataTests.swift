//
//  PostApiDataTests.swift
//  ShopifyTeam4Tests
//
//  Created by Sara Eltlt on 19/06/2023.
//

import XCTest
import Alamofire
@testable import ShopifyTeam4

final class PostApiDataTests: XCTestCase {

    var networkManager : NetworkManegerProtocol!


    override func setUpWithError() throws {
        networkManager = NetworkManager.shared
    }

    override func tearDownWithError() throws {
        super.tearDown()
        networkManager = nil
    }
    
    //MARK: - test post address
    func testAddNewCustomer_Success() {
            // Given
        let expectation = expectation(description: "API post customer")
            let method = "POST"
           let url = URLs.shared.customersURl()
           let customer = CustomerModel(customer: Customer())
            
            // When
         networkManager.addNewCustomer(method: method, url: url, Newcustomer: customer) { customerModel in
             // Then
             if (customerModel != nil){
                 XCTAssertNotNil(customerModel)
                 expectation.fulfill()
             }else{
                 XCTFail("Error")
             }
            }
           waitForExpectations(timeout: 5.0)
            

        }
    func testAddNewCustomer_Failure() {
            // Given
        let expectation = expectation(description: "API post customer")
            let method = "POST"
           let url = "njnjnj"
           let customer = CustomerModel(customer: Customer())
            
            // When
         networkManager.addNewCustomer(method: method, url: url, Newcustomer: customer) { customerModel in
             // Then
             if (customerModel != nil){
                 XCTFail("Error")
             }else{
                 XCTAssertNotNil(customerModel)
                 expectation.fulfill()

             }
            }
           waitForExpectations(timeout: 10)
            

        }


    

 

}
