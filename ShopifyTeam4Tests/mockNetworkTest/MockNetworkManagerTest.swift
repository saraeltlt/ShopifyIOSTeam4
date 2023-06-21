//
//  MockNetworkManagerGetTest.swift
//  ShopifyTeam4Tests
//
//  Created by Sara Eltlt on 20/06/2023.
//

import XCTest
@testable import ShopifyTeam4

final class MockNetworkManagerGetTest: XCTestCase {
    var networkManager : NetworkManegerGetProtocol!

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        super.tearDown()
        networkManager = nil
    }

    //MARK: -BrandProductsModel
    func testGetBrandProductsModelResponse_ShouldPass() {
        networkManager = MockNetworkManager(shouldReturnError: false, responseType: .BrandProductsModel)
        networkManager?.getApiData(url: URLs.shared.allProductsURL()) { (result: Result<BrandProductsModel, Error>) in
            switch result {
            case .success(let items):
                XCTAssertGreaterThan(items.brandProducts?.count ?? 0, 0, "Error decoding data")
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    //MARK: -GetOrderModel
    func testGetOrderModelResponse_ShouldPass() {
        networkManager = MockNetworkManager(shouldReturnError: false, responseType: .GetOrderModel)
        networkManager?.getApiData(url: URLs.shared.allProductsURL()) { (result: Result<GetOrderModel, Error>) in
            switch result {
            case .success(let items):
                XCTAssertNotNil(items)
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
        }
    }

    
    //MARK: - DraftOrderModel
    func testDraftOrderModelResponse_ShouldPass() {
        networkManager = MockNetworkManager(shouldReturnError: false, responseType: .DraftOrderModel)
        networkManager?.getApiData(url: URLs.shared.getDaftOrder(draftOrderId: 1116324626717)) { (result: Result<DraftOrderModel, Error>) in
            switch result {
            case .success(let items):
                XCTAssertNotNil(items)
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    //MARK: - ProductDetailsModel
    func testProductDetailsModelResponse_ShouldPass() {
        networkManager = MockNetworkManager(shouldReturnError: false, responseType: .ProductDetailsModel)
        networkManager?.getApiData(url: URLs.shared.getProductDetails(productId: 8348491710749)   ) { (result: Result<ProductDetailsModel, Error>) in
            switch result {
            case .success(let items):
                XCTAssertEqual(items.product?.id, 8348491710749)
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    //MARK: -BrandsModel
    func testBrandsModelResponse_ShouldPass() {
        networkManager = MockNetworkManager(shouldReturnError: false, responseType: .BrandsModel)
        networkManager?.getApiData(url: URLs.shared.getBrandsURL()  ) { (result: Result<BrandsModel, Error>) in
            switch result {
            case .success(let items):
                XCTAssertGreaterThan(items.smartCollections?.count ?? 0, 0)
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    //MARK: -CustomerAddressModel
    func testCustomerAddressModelResponse_ShouldPass() {
        networkManager = MockNetworkManager(shouldReturnError: false, responseType: .CustomerAddress)
        networkManager?.getApiData(url: URLs.shared.getAllAddress(id: 7023980937501) ) { (result: Result<CustomerAddress, Error>) in
            switch result {
            case .success(let items):
                XCTAssertNotNil(items)
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
        }
    }

    
    // MARK: - fail
    
    func testGetData_ShouldFail() {
        networkManager = MockNetworkManager(shouldReturnError: true, responseType: .BrandProductsModel)
        networkManager.getApiData(url: URLs.shared.allProductsURL()) { (result: Result<BrandProductsModel, Error>) in
            switch result {
            case .success(let items):
                XCTFail("Unexpected success: \(items)")
            case .failure(let error):
                XCTAssertNotNil(error, "Error should not be nil")
            }
        }
    }

    
    
    
    
    
    
    
    
}
