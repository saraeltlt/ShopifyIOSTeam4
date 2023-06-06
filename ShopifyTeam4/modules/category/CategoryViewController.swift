//
//  CategoryViewController.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 06/06/2023.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var productsCollection: UICollectionView!
    
    @IBOutlet weak var categoryCollection: UICollectionView!
    var categoryArray:[Category]=[Category(title: "Men", image: UIImage(named: "test")!, isSelected: false),Category(title: "Women", image: UIImage(named: "test")!, isSelected: false),Category(title: "Kids", image: UIImage(named: "test")!, isSelected: false),Category(title: "Sale", image: UIImage(named: "test")!, isSelected: false)]
    var actionButton : ActionButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.container.layer.cornerRadius = self.view.bounds.width * 0.09
        self.container.layer.masksToBounds = true
        self.categoryCollection.register(UINib(nibName: K.CategoryViewCell, bundle: nil), forCellWithReuseIdentifier: K.CategoryViewCell)
        self.productsCollection.register(UINib(nibName: "BrandViewCell", bundle: nil), forCellWithReuseIdentifier: K.brandCell)
       setupButtons()
        
    }
    
    func setupButtons(){
        let beauty = ActionButtonItem(title: "Beauty", image: UIImage(named: "test"))
        beauty.action = { [weak self] item in
            self?.actionButton.toggleMenu()
            print("beauty") }
        let Supermarket = ActionButtonItem(title: "Supermarket", image:  UIImage(named: "test"))
        Supermarket.action = { [weak self] item in
            self?.actionButton.toggleMenu()
            print("Supermarket")  }
        let Phones = ActionButtonItem(title: "Phones", image:  UIImage(named: "test"))
        Phones.action = { [weak self] item in
            self?.actionButton.toggleMenu()
            print("Phones")  }
        let Gaming = ActionButtonItem(title: "Gaming", image:  UIImage(named: "test"))
        Gaming.action = { [weak self] item in
            self?.actionButton.toggleMenu()
            print("Gaming")  }
        actionButton = ActionButton(attachedToView: self.view, items: [beauty, Supermarket, Phones, Gaming])
        actionButton.setTitle("+", forState: UIControl.State())
        actionButton.backgroundColor = UIColor(named: "orange")!
        actionButton.action = { button in button.toggleMenu()}
    }
    

    

}


extension CategoryViewController:UICollectionViewDelegate
,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == categoryCollection {
            return 1
        }else {
            return 1
        }
       
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollection {
            return categoryArray.count
        }else {
            return 20
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CategoryViewCell, for: indexPath)
            as! CategoryViewCell
            cell.container.layer.cornerRadius = collectionView.bounds.height*0.17
            cell.container.layer.masksToBounds = true
            cell.categoryImage.image=categoryArray[indexPath.row].image
            cell.categoryTitle.text=categoryArray[indexPath.row].title
            if self.categoryArray[indexPath.row].isSelected{
                cell.container.backgroundColor=UIColor(named: "lightOrange")
            } else {
                cell.container.backgroundColor = .clear
            }
            return cell
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.brandCell, for: indexPath)
            as! BrandViewCell
            cell.outerContainer.layer.cornerRadius = self.productsCollection.bounds.width * 0.03
            cell.innerContainer.layer.cornerRadius = self.productsCollection.bounds.width * 0.035
            cell.brandImage.image=UIImage(named: "test")
            cell.brandName.text="H&M"
            cell.addToFavorite.isHidden = false
            return cell
            
        }
        
    
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        if collectionView == categoryCollection {
            return CGSize(width: (collectionView.bounds.width*0.2), height: (collectionView.bounds.height*1.0))
        }else {
            return CGSize(width: (collectionView.bounds.width*0.45), height: (collectionView.bounds.height*0.45))
        }
  
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == categoryCollection {
            return  20
        }else {
            return  20
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        if collectionView == categoryCollection {
            return  0.1
        }else {
            return  0.1
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == categoryCollection {
            return UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 5)
        }else {
            return UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == categoryCollection {
            self.changeSelectedCellBackground(index: indexPath.row)
        }else {

        }

     
    }
    
    
    func changeSelectedCellBackground(index:Int){
        self.categoryArray.forEach({ item in
            item.isSelected = false
        })
        
        self.categoryArray[index].isSelected = true
        
        self.categoryCollection.reloadData()
        
    }
    
    
    
    
    
    
    
}
