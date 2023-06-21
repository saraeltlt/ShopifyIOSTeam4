//
//  File.swift
//  ShopifyTeam4Tests
//
//  Created by Youssef Mohamed on 20/06/2023.
//

import XCTest
@testable import ShopifyTeam4

class RealmDBServicesTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testInitRealmFile() {
        // Arrange
        let realmDBServices = MockDatabase()

        // Act
        let _ = realmDBServices.initRealmFile(complitionHandler: { errorMessage in
            // Assert
            XCTAssertEqual(errorMessage, "No products found")
        })

    }

    func testAddProduct() {
        // Arrange
        let realmDBServices = MockDatabase()
        let product = ProductFavorite(id: 1, name: "Product 1", image: "image.png", price: "$10")

        // Act
        let _ = realmDBServices.addProduct(product: product, completionHandler: { errorMessage in
            // Assert
            XCTAssertNil(errorMessage)
        })

        // Assert
        XCTAssertEqual(realmDBServices.products.last, product)
    }

    func testGetProductsCount() {
        // Arrange
        let realmDBServices = MockDatabase()
        let product1 = ProductFavorite(id: 1, name: "Product 1", image: "image.png", price: "$10")
        let product2 = ProductFavorite(id: 2, name: "Product 2", image: "image.png", price: "$20")
        realmDBServices.addProduct(product: product1){errorMessage in }
        realmDBServices.addProduct(product: product2){errorMessage in }

        // Act
        let _ = realmDBServices.getProductsCount(ofType: ProductFavorite.self, completionHandler: { errorMessage, productsCount in
            // Assert
            XCTAssertNil(errorMessage)
            XCTAssertEqual(productsCount, 2)
        })

    }

    func testDeleteAllProducts() {
        // Arrange
        let realmDBServices = MockDatabase()
        let product1 = ProductFavorite(id: 1, name: "Product 1", image: "image.png", price: "$10")
        let product2 = ProductFavorite(id: 2, name: "Product 2", image: "image.png", price: "$20")
        realmDBServices.addProduct(product: product1) {errorMessage in }
        realmDBServices.addProduct(product: product2) {errorMessage in }

        // Act
        let _ = realmDBServices.deleteAllProducts(ofType: ProductFavorite.self, completionHandler: { errorMessage in
            // Assert
            XCTAssertNil(errorMessage)
            XCTAssertEqual(realmDBServices.products.count, 0)
        })

    }
    func testDeleteProductById() {
    // Arrange
    let realmDBServices = MockDatabase()
    let product1 = ProductFavorite(id: 1, name: "Product 1", image: "image.png", price: "$10")
    let product2 = ProductFavorite(id: 2, name: "Product 2", image: "image.png", price: "$20")
        realmDBServices.addProduct(product: product1) {errorMessage in XCTAssertNil(errorMessage) }
        realmDBServices.addProduct(product: product2) {errorMessage in
            XCTAssertNil(errorMessage)
        }

    // Act
    let _ = realmDBServices.deleteProductById(ofType: ProductFavorite.self, id: 1, completionHandler: { errorMessage in
        // Assert
        XCTAssertEqual(realmDBServices.products.count, 1)
    })
}

func testGetIDsOfAllFavoriteItems() {
    // Arrange
    let realmDBServices = MockDatabase()
    let product1 = ProductFavorite(id: 1, name: "Product 1", image: "image.png", price: "$10")
    let product2 = ProductFavorite(id: 2, name: "Product 2", image: "image.png", price: "$20")
    realmDBServices.addProduct(product: product1) {errorMessage in
        XCTAssertNil(errorMessage)
    }
    realmDBServices.addProduct(product: product2) {errorMessage in
        XCTAssertNil(errorMessage)
    }

    // Act
    let _ = realmDBServices.getIDsOfAllFavoriteItems(complitionHandler: { errorMessage, idsOfFavoriteItems in
        // Assert
        XCTAssertNil(errorMessage)
        XCTAssertEqual(idsOfFavoriteItems?.count, 2)
    })
}
}
