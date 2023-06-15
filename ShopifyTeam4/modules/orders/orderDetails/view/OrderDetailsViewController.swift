//
//  OrderDetailsViewController.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 11/06/2023.
//

import UIKit

class OrderDetailsViewController: UIViewController {
    var viewModel:OrderDetailsViewModel?
    
    @IBOutlet weak var orderPrice: UILabel!
    @IBOutlet weak var orderAddress: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var productsCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeaderData()
        self.container.layer.cornerRadius = self.view.bounds.width * 0.09
        self.container.layer.masksToBounds = true
        self.productsCollection.register(UINib(nibName: K.BRANDS_CELL, bundle: nil), forCellWithReuseIdentifier: K.BRANDS_CELL)
    }
    func configureHeaderData(){
        self.orderDate.text = viewModel?.configureHeaderData().date 
        self.orderPrice.text = viewModel?.configureHeaderData().price
        self.orderAddress.text = viewModel?.configureHeaderData().address
    }
}



extension OrderDetailsViewController:UICollectionViewDelegate
,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getProductsCount() ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.BRANDS_CELL, for: indexPath)
        as! BrandViewCell
        let productData = viewModel?.getProductData(index: indexPath.row)
        var data = productData?.price
        cell.configureCell(title: productData?.title ?? "", imageUrl: productData?.imagSrc ?? "", price: (productData?.price)?.stringValue() ?? "",numberOfItems: "x2")
        cell.addToFavorite.isHidden = true
        return cell
    
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        return CGSize(width: (collectionView.bounds.width*0.45), height: (collectionView.bounds.height*0.45))
  
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  20
    
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return  0.1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
    
}
