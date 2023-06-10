//
//  CategoryViewModel.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 08/06/2023.
//

import Foundation
import UIKit

class CategoryViewModel{
    var products:Observable<Bool>=Observable(false)
    var categoryProductsArray  = [Brand]()
    var filteredProductsArray = [Brand] ()
    var isFiltering = false
    var categoryArray:[Category]=[Category(title: "Men", image: UIImage(named: K.MEN)!, isSelected: false, categoryId: 448684196125),Category(title: "Women", image: UIImage(named: K.WOMEN)!, isSelected: false, categoryId: 448684261661),Category(title: "Kids", image: UIImage(named: K.KIDS)!, isSelected: false, categoryId: 448684294429),Category(title: "Sale", image: UIImage(named: K.SALE)!, isSelected: false, categoryId: 448684327197)]
    
    func getCategoryProducts(categoryId:Int){
        let url = URLs.shared.categoryProductsURL(id: categoryId)
                NetworkManager.shared.getApiData(url: url) { [weak self] (result: Result<BrandProductsModel, Error>) in
                    switch result {
                    case .success(let products):
                        self?.categoryProductsArray = products.brandProducts!
                        self?.products.value = true
                    case .failure(let error):
                        print(error)
                    }
                }
    }
    
    func getAllProducts(){
        let url = URLs.shared.allProductsURL()
                NetworkManager.shared.getApiData(url: url) { [weak self] (result: Result<BrandProductsModel, Error>) in
                    switch result {
                    case .success(let products):
                        self?.categoryProductsArray = products.brandProducts!
                        self?.products.value = true
                    case .failure(let error):
                        print(error)
                    }
                }
    }
    
    
    
    
    
    
    
    
    
    
    func getCategoriesCount()->Int{
        return categoryArray.count
    }
    
    func getCategoryData(index:Int)->Category{
        return categoryArray[index]
    }
    
    
    func getProductsCount()->Int{
        if !isFiltering{
            return categoryProductsArray.count
        } else {
            return filteredProductsArray.count
        }
    }
    
    func getProductData(index:Int)->Brand{
        if !isFiltering{
            return categoryProductsArray[index]
        } else {
            return filteredProductsArray[index]
        }
    }
    
    func filterProductsArray(productType:String){
        filteredProductsArray = categoryProductsArray.filter({
            $0.product_type == productType
        })
    }
    
    
    
    
    func changeCategoriesIsSelectedStatus(index:Int){
        self.categoryArray.forEach({ item in
            item.isSelected = false
        })
        self.categoryArray[index].isSelected = true
        
        self.getCategoryProducts(categoryId: self.getCategoryData(index: index).categoryId)
    }
}
