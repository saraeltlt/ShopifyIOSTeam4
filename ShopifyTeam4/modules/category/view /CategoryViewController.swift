//
//  CategoryViewController.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 06/06/2023.
//

import UIKit
import Lottie

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var internetStatusView: UIView!
    @IBOutlet weak var loadingAnimation: LottieAnimationView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noResultText: UIButton!
    @IBOutlet weak var noResultImage: UIImageView!
    @IBOutlet weak var shoppingCartCount: UIBarButtonItem!
    @IBOutlet weak var favoritesCount: UIBarButtonItem!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var productsCollection: UICollectionView!
    @IBOutlet weak var categoryCollection: UICollectionView!
    var actionButton : ActionButton!
    var viewModel = CategoryViewModel()
    var currentItemFavoriteModel:ProductFavorite!
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
        self.navigationController?.navigationBar.isHidden=false
        configureInternetConnectionObservation()
        configureFavoritesCountObservation()
        configureShoppingCartCountObservation()
        viewModel.getAllSotredFavoriteItems()
        viewModel.getAllSotredShoppingCardItems()
        searchBar.text = ""
        viewModel.categoryProductsArray = viewModel.backupCategoryProductsArray
        viewModel.filteredProductsArray = viewModel.backupFilteredCategoryProductsArray
       // productsCollection.reloadData()
    }
    
    
    func setupButtons(){
        let t_shirts = ActionButtonItem(title: "T-SHIRTS", image: UIImage(named: K.TSHIRT))
        t_shirts.action = { [weak self] item in
            self?.actionButton.toggleMenu()
            if self?.viewModel.categoryProductsArray.count == 0{
                self?.viewModel.categoryProductsArray = (self?.viewModel.backupCategoryProductsArray)!
            }
            self?.viewModel.filterProductsArray(productType: "T-SHIRTS")
            self?.viewModel.isFiltering = true
            self?.searchBar.text = ""
            if self?.viewModel.categoryProductsArray.count == 0{
                self?.viewModel.categoryProductsArray = (self?.viewModel.backupCategoryProductsArray)!
            }
            self?.productsCollection.reloadData()
        }
        let shoes = ActionButtonItem(title: "SHOES", image:  UIImage(named: K.SHOES))
        shoes.action = { [weak self] item in
            self?.actionButton.toggleMenu()
            if self?.viewModel.categoryProductsArray.count == 0{
                self?.viewModel.categoryProductsArray = (self?.viewModel.backupCategoryProductsArray)!
            }
            self?.viewModel.filterProductsArray(productType: "SHOES")
            self?.viewModel.isFiltering = true
            self?.searchBar.text = ""
            if self?.viewModel.categoryProductsArray.count == 0{
                self?.viewModel.categoryProductsArray = (self?.viewModel.backupCategoryProductsArray)!
            }
            self?.productsCollection.reloadData()
        }
        let accessories = ActionButtonItem(title: "ACCESSORIES", image:  UIImage(named: K.ACCESSORISE))
        accessories.action = { [weak self] item in
            self?.actionButton.toggleMenu()
            if self?.viewModel.categoryProductsArray.count == 0{
                self?.viewModel.categoryProductsArray = (self?.viewModel.backupCategoryProductsArray)!
            }
            self?.viewModel.filterProductsArray(productType: "ACCESSORIES")
            self?.viewModel.isFiltering = true
            self?.searchBar.text = ""
            self?.productsCollection.reloadData()
        }
        actionButton = ActionButton(attachedToView: self.view, items: [t_shirts, shoes, accessories])
        actionButton.setTitle("+", forState: UIControl.State())
        actionButton.backgroundColor = UIColor(named: "orange")!
        actionButton.action = { button in button.toggleMenu()}
    }
    @IBAction func navigateToFavoriteScreen(_ sender: UIBarButtonItem) {
        if (K.GUEST_MOOD){
            self.GuestMoodAlert()
        }else{
            let storyboard = UIStoryboard(name: "Favorites", bundle: nil)
            let favoriteVC = storyboard.instantiateViewController(withIdentifier: "FavoriteViewController") as! FavoriteViewController
            self.navigationController?.pushViewController(favoriteVC, animated: true)
        }
    }
    
    @IBAction func navigateToShoppingCart(_ sender: UIBarButtonItem) {
        if (K.GUEST_MOOD){
            self.GuestMoodAlert()
        }else{
            let storyboard = UIStoryboard(name: "Profile", bundle: nil)
            let shoppingCartVC = storyboard.instantiateViewController(withIdentifier: "ShoppingCartViewController") as! ShoppingCartViewController
            self.navigationController?.pushViewController(shoppingCartVC, animated: true)
        }
    }
    
    func configureFavoritesCountObservation(){
        viewModel.favoritesCount.bind { count in
            guard let count = count else {return}
                if let view = self.favoritesCount.value(forKey: "view") as? UIView {
                    if count > 0 {
                        view.addBadge(text: "\(count)",color: K.ORANGE)
                    } else {
                        view.removeBadge()
                    }
                   }
            
        }
    }

    func configureShoppingCartCountObservation(){
        viewModel.CartItemsCount.bind { count in
            guard let count = count else {return}
                if let view = self.shoppingCartCount.value(forKey: "view") as? UIView {
                    if count > 0 {
                        view.addBadge(text: "\(count)",color: K.ORANGE)
                    }else {
                        view.removeBadge()
                    }
                   }
            
        }
    }
    
    func checkLoadingDataStatus(){
        if viewModel.products.value == false {
            startAnimation()
        } else {
            stopAnimation()
            if viewModel.getProductsCount() == 0 {
                showEmptyStatus()
            }else {
                HideEmptyStatus()
            }
            
        }
    }
    
    func startAnimation(){
        loadingAnimation.animationSpeed=1.5
        loadingAnimation.loopMode = .loop
        loadingAnimation.play()
    }
    func stopAnimation(){
        loadingAnimation.isHidden = true
    }
    func showEmptyStatus(){
        noResultImage.isHidden = false
        noResultText.isHidden = false
    }
    func HideEmptyStatus(){
        noResultImage.isHidden = true
        noResultText.isHidden = true
    }
    
    func configureInternetConnectionObservation(){
        InternetConnectionObservation.getInstance.internetConnection.bind { status in
            guard let status = status else {return}
            if status {
                print("there is internet connection in category")
                DispatchQueue.main.async {
                    self.internetStatusView.isHidden = true
                }
                self.viewModel.getAllProducts()
            }else {
                print("there is no internet connection in category")
                DispatchQueue.main.async {
                    self.internetStatusView.isHidden = false
                }
            }
        }
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
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollection {
            return viewModel.getCategoriesCount()
        }else {
            checkLoadingDataStatus()
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
            if K.idsOfFavoriteProducts.contains(product.id!){
                cell.addToFavorite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                cell.addToFavorite.isFavoriteItem = true
            }else{
                cell.addToFavorite.setImage(UIImage(systemName: "heart"), for: .normal)
                cell.addToFavorite.isFavoriteItem = false
            }
            cell.addToFavorite.cellIndex = indexPath.row
            cell.addToFavorite.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            return cell
            
        }
        
    }
    
    @objc func buttonTapped(_ sender: FavoriteButton) {
        if (K.GUEST_MOOD){
            self.GuestMoodAlert()
        }
        else{
            var currentProduct = viewModel.getProductData(index: sender.cellIndex)
            currentItemFavoriteModel = ProductFavorite(id: currentProduct.id!, name: currentProduct.title!, image: (currentProduct.images?.first?.src)!, price: (currentProduct.variants?.first?.price)!)
            if sender.isFavoriteItem{
                confirmAlert { [weak self] in
                    guard let self = self else {return}
                    let msg = viewModel.removeFromFavorite(productId: currentItemFavoriteModel.id)
                    if msg == "Product removed successfully"{
                        self.view.makeToast(msg, duration: 2 ,title: "removing from favorites" ,image: UIImage(named: K.SUCCESS_IMAGE))
                        sender.setImage(UIImage(systemName: "heart"), for: .normal)
                        sender.isFavoriteItem = false
                        guard let itemIndex = K.idsOfFavoriteProducts.firstIndex(of: currentItemFavoriteModel.id) else { return  }
                        K.idsOfFavoriteProducts.remove(at: itemIndex)
                        viewModel.getAllSotredFavoriteItems()
                    }else{
                        errorTitledAlert(subTitle: msg, handler: nil)
                    }
                }
            }else{
                let msg = viewModel.addToFavorite(product: currentItemFavoriteModel)
                if msg == "Product added successfully"{
                    self.view.makeToast(msg, duration: 2 ,title: "Adding to favorites" ,image: UIImage(named: K.SUCCESS_IMAGE))
                    sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    sender.isFavoriteItem = true
                    K.idsOfFavoriteProducts.append(currentItemFavoriteModel.id)
                    viewModel.getAllSotredFavoriteItems()
                }else{
                    errorTitledAlert(subTitle: msg, handler: nil)
                }
            }
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
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == categoryCollection {
            return CGSize(width: (collectionView.bounds.width*0.15), height: (collectionView.bounds.height*1.0))
        }else {
            return CGSize(width: (collectionView.bounds.width*0.45), height: (collectionView.bounds.height*0.45))
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  20
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  0.1
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
            searchBar.text = ""
        }else {
            let storyboard = UIStoryboard(name: "ProductDetails", bundle: nil)
            let detailsVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
            detailsVC.productId = viewModel.getProductData(index: indexPath.row).id ?? 0
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
extension CategoryViewController:UISearchBarDelegate{
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            viewModel.categoryProductsArray = viewModel.backupCategoryProductsArray
            viewModel.filteredProductsArray = viewModel.backupFilteredCategoryProductsArray
            productsCollection.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }else{
            viewModel.categoryProductsArray = viewModel.backupCategoryProductsArray
            viewModel.filteredProductsArray = viewModel.backupFilteredCategoryProductsArray
            viewModel.categoryProductsArray = viewModel.categoryProductsArray.filter({ (product) -> Bool in
                product.title!.starts(with: searchText.lowercased()) || product.title!.starts(with: searchText.uppercased())
            })
            viewModel.filteredProductsArray = viewModel.filteredProductsArray.filter({ (product) -> Bool in
                product.title!.starts(with: searchText.lowercased()) || product.title!.starts(with: searchText.uppercased())
            })
            productsCollection.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        viewModel.categoryProductsArray = viewModel.backupCategoryProductsArray
        viewModel.filteredProductsArray = viewModel.backupFilteredCategoryProductsArray
        productsCollection.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (collectionView == productsCollection){
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
            cell.layer.transform = rotationTransform
            cell.alpha = 0.5
            
            UIView.animate(withDuration: 1.0) {
                cell.layer.transform = CATransform3DIdentity
                cell.alpha = 1.0
            }
        }
    }
}
