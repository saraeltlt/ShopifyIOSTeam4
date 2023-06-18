//
//  ViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 03/06/2023.
//

import UIKit

class HomeViewController: UIViewController {
    

    
  
    
    @IBOutlet weak var noResultImage: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var CartItemsCount: UIBarButtonItem!
    @IBOutlet weak var favoriteCount: UIBarButtonItem!

    @IBOutlet weak var adsCollection: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var brandsCollection: UICollectionView!
    @IBOutlet weak var container: UIView!
    var timer:Timer?
    var currentCellIndex=0
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(K.USER_ID)
        configureBrandCollectionObservation()
        viewModel.initIdsOfFavoriteItemsArray()
        viewModel.setLoggedUserName()
        viewModel.getBrandsData()
        self.adsCollection.register(UINib(nibName: K.ADS_CELL, bundle: nil), forCellWithReuseIdentifier: K.ADS_CELL)
        self.brandsCollection.register(UINib(nibName: K.BRANDS_CELL, bundle: nil), forCellWithReuseIdentifier: K.BRANDS_CELL)
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
        self.pageController.numberOfPages = viewModel.getadvertesmentsCount()
        self.container.layer.cornerRadius = self.view.bounds.width * 0.15
        self.container.layer.masksToBounds = true
        if let tabBarController = self.tabBarController {
            if let tabItems = tabBarController.tabBar.items {
                if tabItems.count >= 3 {
                    let secondTabBarItem = tabItems[2]
                    secondTabBarItem.image = UIImage(systemName: "person.crop.circle.fill")
                    secondTabBarItem.title = "Profile"
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureFavoritesCountObservation()
        configureShoppingCartCountObservation()
        viewModel.getAllSotredFavoriteItems()
        viewModel.getAllSotredShoppingCardItems()
        searchBar.text = ""
        noResultImage.isHidden = true
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
    
    
    @IBAction func navigateToFavoriteItems(_ sender: UIBarButtonItem) {
        if (K.GUEST_MOOD){
            self.GuestMoodAlert()
        }else{
            let storyboard = UIStoryboard(name: "Favorites", bundle: nil)
            let favoriteVC = storyboard.instantiateViewController(withIdentifier: "FavoriteViewController") as! FavoriteViewController
            self.navigationController?.pushViewController(favoriteVC, animated: true)
        }

    }
    
    func configureFavoritesCountObservation(){
        viewModel.favoritesCount.bind { count in
            guard let count = count else {return}
                if let view = self.favoriteCount.value(forKey: "view") as? UIView {
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
                if let view = self.CartItemsCount.value(forKey: "view") as? UIView {
                    if count > 0 {
                        view.addBadge(text: "\(count)",color: K.ORANGE)
                    }else {
                        view.removeBadge()
                    }
                   }
            
        }
    }
    

}



extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func configureBrandCollectionObservation(){
        viewModel.brands.bind { status in
            guard let status = status else {return}
            if status {
                DispatchQueue.main.async {
                    self.brandsCollection.reloadData()
                }
            }
        }
    }
    
    @objc func moveToNextIndex(){
        if currentCellIndex < viewModel.getadvertesmentsCount() - 1 {
            currentCellIndex += 1
        }else {
            currentCellIndex = 0
        }
        self.adsCollection.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        self.pageController.currentPage = currentCellIndex
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == adsCollection {
            return 1
        }else {
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == adsCollection {
            return viewModel.getadvertesmentsCount()
        }else {
            let numberOfItems = viewModel.getBrandsCount()
            if numberOfItems == 0{
                noResultImage.isHidden = false
            }else{
                noResultImage.isHidden = true
            }
            return numberOfItems
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == adsCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.ADS_CELL, for: indexPath)
            as! AdvertisementsViewCell
            cell.configureCell(image: viewModel.getadvertesmentsData(index: indexPath.row))
       
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.BRANDS_CELL, for: indexPath)
            as! BrandViewCell
            let brandData = viewModel.getBrandData(index: indexPath.row)
            cell.configureCell(title: brandData.title ?? "", imageUrl: brandData.image?.src ?? "")
            cell.addToFavorite.isHidden = true
            return cell
        }
        
        
      
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == adsCollection {
            return CGSize(width: (collectionView.bounds.width*1.0), height: (collectionView.bounds.height*1.0))
        }else {
            return CGSize(width: (collectionView.bounds.width*0.5), height: (collectionView.bounds.height*1.0))
        }
  
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == adsCollection {
           return 20
        }else {
          return  20
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == adsCollection {
           return 0
        }else {
          return  0
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
        if collectionView == adsCollection {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        
            if collectionView == adsCollection {
                var promoCode="%"
                switch indexPath.row{
                case 0:
                    promoCode=K.COUPONS.save15.rawValue
                case 1:
                  
                    promoCode=K.COUPONS.save50.rawValue
                default:
                    promoCode=K.COUPONS.saveLimited80.rawValue
                }
                let pasteboard = UIPasteboard.general
                pasteboard.string = promoCode
                self.view.makeToast("Coupon copied to the clipboard", duration: 2 ,title: promoCode ,image: UIImage(named: K.COUPON_IMAGE))
            }else {
                let brandProducts = self.storyboard?.instantiateViewController(identifier: "brandProducts")
                as! BrandProductsViewController
                brandProducts.viewModel = viewModel.navigationConfigure(for: indexPath.row)
                self.navigationController?.pushViewController(brandProducts, animated: true)
            }
    }
    
}
extension HomeViewController:UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        viewModel.brandsArray = viewModel.backupBrandsArray
        brandsCollection.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            viewModel.brandsArray = viewModel.backupBrandsArray
            brandsCollection.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }else{
            viewModel.brandsArray = viewModel.backupBrandsArray
            viewModel.brandsArray = viewModel.brandsArray.filter({ (product) -> Bool in
                product.title!.starts(with: searchText.lowercased()) || product.title!.starts(with: searchText.uppercased())
            })
          brandsCollection.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

}
