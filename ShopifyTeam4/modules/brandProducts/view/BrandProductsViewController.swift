//
//  BrandProductsViewController.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 06/06/2023.
//

import UIKit

class BrandProductsViewController: UIViewController {
    
    @IBOutlet weak var priceFilter: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var filterContainer: UIView!
    @IBOutlet weak var filterContainerHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var productsCollection: UICollectionView!
    var isFilterHidden = true
    var viewModel:BrandProductsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureProductsCollectionObservation()
        viewModel?.getBrandProducts()
        self.container.layer.cornerRadius = self.view.bounds.width * 0.050
        self.container.layer.masksToBounds = true
        self.filterContainerHeightConstrain.constant += -self.view.bounds.height*0.0551643
        self.view.layoutIfNeeded()
        self.filterContainer.isHidden = true
        self.productsCollection.register(UINib(nibName: K.BRANDS_CELL, bundle: nil), forCellWithReuseIdentifier: K.BRANDS_CELL)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        productsCollection.reloadData()

    }
    
    @IBAction func priceFilterSlider(_ sender: UISlider) {
        priceFilter.text = "Price : \(Int(sender.value))"
        
    }
   
    @IBAction func filter(_ sender: UIBarButtonItem) {
        if isFilterHidden{
            self.filterContainerHeightConstrain.constant += self.view.bounds.height*0.0551643
            self.view.layoutIfNeeded()
            self.filterContainer.isHidden = false
            isFilterHidden = false
        } else {
            self.filterContainerHeightConstrain.constant += -self.view.bounds.height*0.0551643
            self.view.layoutIfNeeded()
            self.filterContainer.isHidden = true
            isFilterHidden = true
        }
    }
}




extension BrandProductsViewController:UICollectionViewDelegate
,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func configureProductsCollectionObservation(){
        viewModel?.products.bind({ status in
            guard let status = status else {return}
            if status {
                DispatchQueue.main.async {
                    self.productsCollection.reloadData()
                }
            }
        })
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
       
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getProductsCount() ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.BRANDS_CELL, for: indexPath)
        as! BrandViewCell
        let productData = viewModel?.getProductData(index: indexPath.row)
        cell.configureCell(title: productData?.title ?? "", imageUrl: productData?.image?.src ?? "", price: productData?.variants?[0].price ?? "")
        cell.addToFavorite.isHidden = false
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
