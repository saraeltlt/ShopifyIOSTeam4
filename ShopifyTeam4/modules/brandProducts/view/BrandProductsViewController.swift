//
//  BrandProductsViewController.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 06/06/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Lottie

class BrandProductsViewController: UIViewController {
    
    @IBOutlet weak var internetConnectionStatus: UIView!
    var disposBag = DisposeBag()
    @IBOutlet weak var loadingAnimation: LottieAnimationView!
    @IBOutlet weak var priceSliderFilter: UISlider!
    @IBOutlet weak var priceFilter: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var filterContainer: UIView!
    @IBOutlet weak var filterContainerHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var productsCollection: UICollectionView!
    var isFilterHidden = true
    var viewModel:BrandProductsViewModel?
    var currentItemFavoriteModel:ProductFavorite!
    @IBOutlet weak var noResultText: UIButton!
    @IBOutlet weak var noResultImage: UIImageView!
    
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
        configureInternetConnectionObservation()
        self.navigationController?.navigationBar.isHidden=false
        productsCollection.reloadData()
        if K.CURRENCY == "EGP" {
            self.priceSliderFilter.maximumValue = 10000
        } else {
            self.priceSliderFilter.maximumValue = 300
        }
        viewModel?.brandProductsArray = viewModel!.backupBrandProductsArray
        setUpPriceFilterObservation()
        productsCollection.reloadData()
    }
    
    @IBAction func priceFilterSlider(_ sender: UISlider) {
        priceFilter.text = "Price : \(Int(sender.value))"
        
    }
    
    func setUpPriceFilterObservation(){
        priceSliderFilter.rx.controlEvent(.valueChanged).debounce(.seconds(1), scheduler: MainScheduler.instance).subscribe{
            print(self.priceSliderFilter.value)
            var filterPrice = self.priceSliderFilter.value
            self.viewModel?.filterProducts(price: filterPrice)
            self.productsCollection.reloadData()
        }onCompleted: { print("completed")
        }.disposed(by: disposBag)
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
    
    func checkLoadingDataStatus(){
        if viewModel?.products.value == false {
            startAnimation()
        } else {
            stopAnimation()
            if viewModel?.getProductsCount() == 0 {
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
                    self.internetConnectionStatus.isHidden = true
                }
                self.viewModel?.getBrandProducts()
            }else {
                print("there is no internet connection in category")
                DispatchQueue.main.async {
                    self.internetConnectionStatus.isHidden = false
                }
            }
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
    
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        checkLoadingDataStatus()
        return viewModel?.getProductsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.BRANDS_CELL, for: indexPath)
        as! BrandViewCell
        let productData = viewModel?.getProductData(index: indexPath.row)
        cell.configureCell(title: productData?.title ?? "", imageUrl: productData?.image?.src ?? "", price: productData?.variants?[0].price ?? "")
        cell.addToFavorite.isHidden = false
        if K.idsOfFavoriteProducts.contains((productData?.id)!){
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
    @objc func buttonTapped(_ sender: FavoriteButton) {
        if (K.GUEST_MOOD){
            self.GuestMoodAlert()
        }else{
            var currentProduct = viewModel!.getProductData(index: sender.cellIndex)
            currentItemFavoriteModel = ProductFavorite(id: currentProduct.id!, name: currentProduct.title!, image: (currentProduct.images?.first?.src)!, price: (currentProduct.variants?.first?.price)!)
            if sender.isFavoriteItem{
                confirmAlert { [weak self] in
                    guard let self = self else {return}
                    let msg = viewModel!.removeFromFavorite(productId: currentItemFavoriteModel.id)
                    if msg == "Product removed successfully"{
                        self.view.makeToast(msg, duration: 2 ,title: "removing from favorites" ,image: UIImage(named: K.SUCCESS_IMAGE))
                        sender.setImage(UIImage(systemName: "heart"), for: .normal)
                        sender.isFavoriteItem = false
                        guard let itemIndex = K.idsOfFavoriteProducts.firstIndex(of: currentItemFavoriteModel.id) else { return  }
                        K.idsOfFavoriteProducts.remove(at: itemIndex)
                    }else{
                        errorTitledAlert(subTitle: msg, handler: nil)
                    }
                }
            }else{
                let msg = viewModel!.addToFavorite(product: currentItemFavoriteModel)
                if msg == "Product added successfully"{
                    self.view.makeToast(msg, duration: 2 ,title: "Adding to favorites" ,image: UIImage(named: K.SUCCESS_IMAGE))
                    sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    sender.isFavoriteItem = true
                    K.idsOfFavoriteProducts.append(currentItemFavoriteModel.id)
                }else{
                    errorTitledAlert(subTitle: msg, handler: nil)                }
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
        let storyboard = UIStoryboard(name: "ProductDetails", bundle: nil)
        let detailsVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        detailsVC.productId = viewModel?.brandProductsArray[indexPath.row].id ?? 0
        detailsVC.modalPresentationStyle = .fullScreen
        detailsVC.modalTransitionStyle = .crossDissolve
        present(detailsVC, animated: true)
    }
}
extension BrandProductsViewController:UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.brandProductsArray = viewModel!.backupBrandProductsArray
        productsCollection.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            viewModel?.brandProductsArray = viewModel!.backupBrandProductsArray
            productsCollection.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }else{
            viewModel?.brandProductsArray = viewModel!.backupBrandProductsArray
            viewModel!.brandProductsArray = viewModel!.brandProductsArray.filter({ (product) -> Bool in
                product.title!.starts(with: searchText.lowercased()) || product.title!.starts(with: searchText.uppercased())
            })
            productsCollection.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
            cell.layer.transform = rotationTransform
            cell.alpha = 0.5
            
            UIView.animate(withDuration: 1.0) {
                cell.layer.transform = CATransform3DIdentity
                cell.alpha = 1.0
            }
    }
}
