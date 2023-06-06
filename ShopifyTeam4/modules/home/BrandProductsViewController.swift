//
//  BrandProductsViewController.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 06/06/2023.
//

import UIKit

class BrandProductsViewController: UIViewController {
    var isFilterHidden = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.container.layer.cornerRadius = self.view.bounds.width * 0.050
        self.container.layer.masksToBounds = true
        self.productsCollection.register(UINib(nibName: "BrandViewCell", bundle: nil), forCellWithReuseIdentifier: K.brandCell)
        
    }
    
    @IBAction func priceFilterSlider(_ sender: UISlider) {
        priceFilter.text = "Price : \(Int(sender.value))"
        
    }
    @IBOutlet weak var priceFilter: UILabel!
    @IBAction func filter(_ sender: UIBarButtonItem) {
        if !isFilterHidden{
            self.filterContainerHeightConstrain.constant += -self.view.bounds.height*0.0551643
            self.view.layoutIfNeeded()
            self.filterContainer.isHidden = true
            print("minimize")
            isFilterHidden = true
        } else {
            self.filterContainerHeightConstrain.constant += self.view.bounds.height*0.0551643
            self.view.layoutIfNeeded()
            self.filterContainer.isHidden = false
            print("maximize")
            isFilterHidden = false
        }
        
    
    
    }
    
    @IBOutlet weak var container: UIView!
    
    
    @IBOutlet weak var filterContainer: UIView!
    
    
    
    @IBOutlet weak var filterContainerHeightConstrain: NSLayoutConstraint!
    
    @IBOutlet weak var productsCollection: UICollectionView!
    
    
}



extension BrandProductsViewController:UICollectionViewDelegate
,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
       
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.brandCell, for: indexPath)
        as! BrandViewCell
        cell.outerContainer.layer.cornerRadius = self.productsCollection.bounds.width * 0.03
        cell.innerContainer.layer.cornerRadius = self.productsCollection.bounds.width * 0.035
        cell.brandImage.image=UIImage(named: "test")
        cell.brandName.text="H&M"
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
