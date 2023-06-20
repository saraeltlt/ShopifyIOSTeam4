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
    
    //MARK: - test post customer
   /* func testAddNewCustomer_Success() {
        // Given
        let expectation = expectation(description: "API post customer")
        let method = "POST"
        let url = URLs.shared.customersURl()
        let customer = Customer(id: 1, first_name: "sarasarsor" , last_name: "eltltsarsor" , email: "salaMohamed@gmail.com", phone:  "01207979228")
        let customerModel = CustomerModel(customer: customer)
        
        // When
        networkManager.addNewCustomer(method: method, url: url, newCustomer: customerModel) { result in
            // Then
            switch result{
            case .success(let data):
                XCTAssertNotNil(data)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error \(error)")
                
            }
        }
        waitForExpectations(timeout: 10.0)
        
        
    }*/
    
    func testAddNewCustomer_Invalid() {
        // Given
        let expectation = expectation(description: "API post customer")
        let method = "POST"
        let url = "INVALID_URL"
        let customer = CustomerModel(customer: Customer())
        
        // When
        networkManager.addNewCustomer(method: method, url: url, newCustomer: customer) { result in
            //Then
            switch result{
            case .success(let data):
                XCTFail("Expected failure, but received success.")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
                
                
            }
        }
        waitForExpectations(timeout: 10)
        
        
    }
    
    
    
    //MARK: - test post Address
    func testCreateNewAddress_Success() {
        // Arrange
        let url = URLs.shared.addAddress(id: 7023980937501)
        let address = Address(id: 1, address1: "2ded4d3df", city: "C4it3y1", country: "Egypt", phone: "014447243291", isDefault: false)
        
        let expectation = self.expectation(description: "Create address request")
        
        // Act
        networkManager.createNewAddress(url: url, address: address) { result in
            switch result {
            case .success(let response):
                // Assert
                XCTAssertNotNil(response.customer_address)
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail("Request failed with error: \(error)")
            }
        }
        
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    
    
    func testCreateNewAddress_Failure_InvalidURL() {
        // Arrange
        let url = URLs.shared.addAddress(id: 0) //invalid
        let address = Address(id: 1, address1: "123MainSt", city: "City", country: "Egypt", phone: "01206598473", isDefault: false)
        
        let expectation = self.expectation(description: "Create address request")
        
        // Act
        networkManager.createNewAddress(url: url, address: address) { result in
            switch result {
            case .success(let response):
                XCTFail("Request failed with error: \(response)")
                
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
                
            }
        }
        
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    
    func testCreateNewAddress_Failure_InvalidModel() {
        
        let url = URLs.shared.addAddress(id: 7023980937501)
        let address = Address(id: 1, address1: "", city: "", country: "", phone: "", isDefault: false)
        
        let expectation = self.expectation(description: "Create address request")
        
        networkManager.createNewAddress(url: url, address: address) { result in
            switch result {
            case .success(let response):
                XCTFail("Request succeeded with response: \(response)")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    
    
    //MARK: - test post Order
    
    func testPostOrder_success(){
        let customer = Customer(id: 7023980937501,addresses: [Address()])
        let orderProduct = OrderProduct(variant_id: 123, quantity: 2, name: "Product Name", price: .double(9.9), title: "Product Title", imagSrc: "https://example.com/image.jpg")
        let lineItems = [orderProduct]
        let order = Order(id: 53, customer: customer, line_items: lineItems, created_at: "2023-04-10", financial_status: "paid", current_total_price: "\(300)")
        let orderModel = PostOrderModel(order: order)
        
        let url = URLs.shared.postOrder()
        let expectation = self.expectation(description: "Create order request")
        networkManager.createOrder(url: url, order: orderModel) { result in
            switch result{
            case .success(let data):
                XCTAssertNotNil(data)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Request failed with response: \(error)")
                
            }
        }
        waitForExpectations(timeout: 10.0, handler: nil)
        
        
    }
    
    func testPostOrder_Failure_InvalidModel(){
        let order = Order(id: 0, customer: nil, line_items: nil, created_at: "", financial_status: "", current_total_price: "")
        let orderModel = PostOrderModel(order: order)
        let url = URLs.shared.postOrder()
        let expectation = self.expectation(description: "Create order request")
        networkManager.createOrder(url: url, order: orderModel) { result in
            switch result{
            case .success(let data):
                XCTFail("Request succeeded with response: \(String(describing: data?.count))")
                
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
        
    }
    
    func testPostOrder_Failure_InvalidURL(){
        let customer = Customer(id: 7023980937501,addresses: [Address()])
        let orderProduct = OrderProduct(variant_id: 123, quantity: 2, name: "Product Name", price: .double(9.9), title: "Product Title", imagSrc: "https://example.com/image.jpg")
        let lineItems = [orderProduct]
        let order = Order(id: 53, customer: customer, line_items: lineItems, created_at: "2023-04-10", financial_status: "paid", current_total_price: "\(300)")
        let orderModel = PostOrderModel(order: order)
        
        let url = "INVALID_URL"
        let expectation = self.expectation(description: "Create order request")
        networkManager.createOrder(url: url, order: orderModel) { result in
            switch result{
            case .success(let data):
                XCTFail("Request succeeded with response: \(String(describing: data?.count))")
                
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
        
    }
    
    
    //MARK: - test post draftOrder
    func testPostDraftOrder_success(){
        let customer = Customer(id: 7023980937501,addresses: [Address()])
        let draftOrderProduct = DraftOrderProduct(quantity: 2, price: .double(9.99), title: "Product Title", imagSrc: "https://example.com/image.jpg")
        let draftOrder = DraftOrder(id: 123, customer: customer, line_items: [draftOrderProduct])
        let draftOrderModel = DraftOrderModel(draft_order: draftOrder)
        
        let url = URLs.shared.postOrder()
        let expectation = self.expectation(description: "Create post order request")
        networkManager.addDraftOrder(method: "POST", url: url, order: draftOrderModel ) { result in
            switch result{
            case .success(let data):
                XCTAssertNotNil(data)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Request failed with response: \(error)")
                
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
    func testPostDraftOrder_InvalidURL(){
        let customer = Customer(id: 7023980937501,addresses: [Address()])
        let draftOrderProduct = DraftOrderProduct(quantity: 2, price: .double(9.99), title: "Product Title", imagSrc: "https://example.com/image.jpg")
        let draftOrder = DraftOrder(id: 123, customer: customer, line_items: [draftOrderProduct])
        let draftOrderModel = DraftOrderModel(draft_order: draftOrder)
        
        let url = "INVALID_URL"
        let expectation = self.expectation(description: "Create post order request")
        networkManager.addDraftOrder(method: "POST", url: url, order: draftOrderModel ) { result in
            switch result{
            case .success:
                XCTFail("Expected failure, but received success.")
                
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
    
    
    
    
    
    
    
    
}
