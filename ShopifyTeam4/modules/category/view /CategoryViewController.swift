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
    var actionButton : ActionButton!
    var viewModel = CategoryViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureProductsCollectionObservation()
        viewModel.getAllProducts()
        self.container.layer.cornerRadius = self.view.bounds.width * 0.09
        self.container.layer.masksToBounds = true
        self.categoryCollection.register(UINib(nibName: K.CATEGORY_CELL, bundle: nil), forCellWithReuseIdentifier: K.CATEGORY_CELL)
        self.productsCollection.register(UINib(nibName: K.BRANDS_CELL, bundle: nil), forCellWithReuseIdentifier: K.BRANDS_CELL)
       setupButtons()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        productsCollection.reloadData()
        
    }

    
    func setupButtons(){
        let t_shirts = ActionButtonItem(title: "T-SHIRTS", image: UIImage(named: K.TSHIRT))
        t_shirts.action = { [weak self] item in
            self?.actionButton.toggleMenu()
            self?.viewModel.filterProductsArray(productType: "T-SHIRTS")
            self?.viewModel.isFiltering = true
            self?.productsCollection.reloadData()
        }
        let shoes = ActionButtonItem(title: "SHOES", image:  UIImage(named: K.SHOES))
        shoes.action = { [weak self] item in
            self?.actionButton.toggleMenu()
            self?.viewModel.filterProductsArray(productType: "SHOES")
            self?.viewModel.isFiltering = true
            self?.productsCollection.reloadData()
        }
        let accessories = ActionButtonItem(title: "ACCESSORIES", image:  UIImage(named: K.ACCESSORISE))
        accessories.action = { [weak self] item in
            self?.actionButton.toggleMenu()
            self?.viewModel.filterProductsArray(productType: "ACCESSORIES")
            self?.viewModel.isFiltering = true
            self?.productsCollection.reloadData()
        }
        actionButton = ActionButton(attachedToView: self.view, items: [t_shirts, shoes, accessories])
        actionButton.setTitle("+", forState: UIControl.State())
        actionButton.backgroundColor = UIColor(named: "orange")!
        actionButton.action = { button in button.toggleMenu()}
    }
    

    

}


extension CategoryViewController:UICollectionViewDelegate
,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func configureProductsCollectionObservation(){
        viewModel.products.bind({ status in
            guard let status = status else {return}
            if status {
                DispatchQueue.main.async {
                    self.productsCollection.reloadData()
                }
            }
        })
    }
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == categoryCollection {
            return 1
        }else {
            return 1
        }
       
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollection {
            return viewModel.getCategoriesCount()
        }else {
            return viewModel.getProductsCount()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CATEGORY_CELL, for: indexPath)
            as! CategoryViewCell
            let categoryData = viewModel.getCategoryData(index: indexPath.row)
            cell.configureCell(title: categoryData.title, image: categoryData.image)
            if categoryData.isSelected{
                cell.container.backgroundColor=UIColor(named: K.PAIGE)
            } else {
                cell.container.backgroundColor = .clear
            }
            return cell
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.BRANDS_CELL, for: indexPath)
            as! BrandViewCell
            cell.addToFavorite.isHidden = false
            let product = viewModel.getProductData(index: indexPath.row)
            cell.configureCell(title: product.title ?? "", imageUrl: product.image?.src ?? "", price: product.variants?[0].price ?? "" )
            cell.addToFavorite.tag=indexPath.row
            cell.addToFavorite.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            return cell
            
        }
        
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        print("Button tapped in cell at  row \(sender.tag)")
        sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
         let initialSize = CGFloat(17)
          let expandedSize = CGFloat(25)
         UIView.animate(withDuration: 0.5, animations: {
              let originalImage = sender.image(for: .normal)
              let expandedImage = originalImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: expandedSize))
              sender.setImage(expandedImage, for: .normal)
              sender.layoutIfNeeded()
          }) { _ in
              UIView.animate(withDuration: 0.5, animations: {
                  let originalImage = sender.image(for: .normal)
                  let resizedImage = originalImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: initialSize))
                  sender.setImage(resizedImage, for: .normal)
                  sender.layoutIfNeeded()
              })
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
            let storyboard = UIStoryboard(name: "ProductDetails", bundle: nil)
            let detailsVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
            detailsVC.viewModel = viewModel.configNavigation(index: indexPath.row)
            detailsVC.modalPresentationStyle = .fullScreen
            detailsVC.modalTransitionStyle = .crossDissolve
            present(detailsVC, animated: true)
        }

     
    }
    
    
    func changeSelectedCellBackground(index:Int){
        viewModel.changeCategoriesIsSelectedStatus(index: index)
        viewModel.isFiltering = false
        self.categoryCollection.reloadData()
        
    }
    
    
    
    
    
    
    
}
