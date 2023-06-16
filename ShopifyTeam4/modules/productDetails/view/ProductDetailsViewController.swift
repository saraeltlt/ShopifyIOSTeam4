//
//  ProductDetailsViewController.swift
//  ShopifyTeam4
//
//  Created by Youssef Mohamed on 10/06/2023.
//

import UIKit
import ProgressHUD
class ProductDetailsViewController: UIViewController {
    var viewModel : ProductDetailsViewModel!
    var networkIndicator: UIActivityIndicatorView!
    var currentItemFavoriteModel:ProductFavorite!
    @IBOutlet weak var whiteView: UIView!{
        didSet{
            whiteView.layer.cornerRadius = whiteView.bounds.width * 0.15
        }
    }
    @IBOutlet weak var paigeView: UIView!{
        didSet{
            paigeView.layer.cornerRadius = paigeView.bounds.width * 0.15
        }
    }
    @IBOutlet weak var backButton: UIButton!{
        didSet{
            backButton.layer.cornerRadius = backButton.bounds.width * 0.5
        }
    }
    @IBOutlet weak var addToCardBtnBackgroundView: UIView!{
        didSet{
            addToCardBtnBackgroundView.layer.cornerRadius = addToCardBtnBackgroundView.bounds.height * 0.4
        }
    }
    
    @IBOutlet weak var addToFavoriteButtonOutlet: UIButton!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionTextView: UITextView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    var timer:Timer?
    var currentIndex = 0
    var imagesArray:[String] = []
    var productId = 0
    var price = ""
    var isFavoriteitem = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ProductDetailsViewModel(productId: productId)
        networkIndicator = UIActivityIndicatorView(style: .large)
        networkIndicator.color = UIColor(named: K.GREEN)
        networkIndicator.center = view.center
        view.addSubview(networkIndicator)
        viewModel.getProductDetails()
        networkIndicator.startAnimating()
        viewModel.successClosure = { [weak self] (productDetails) in
            guard let self = self else {return}
            self.imagesArray = productDetails.imagesArray
            self.productNameLabel.text = productDetails.name
            price = productDetails.price
            if (K.CURRENCY == "USD"){
                price = "\(price) USD"
            } else {
                let result = Int(Double(price)! * K.EXCHANGE_RATE)
                price = "\(result) EGP"
            }
            self.productPriceLabel.text = price
            self.productDescriptionTextView.text = productDetails.description
            productImagesCollectionView.reloadData()
            self.pageController.numberOfPages = imagesArray.count
            currentItemFavoriteModel = ProductFavorite(id: productDetails.id, name: productDetails.name, image: productDetails.imagesArray.first ?? "", price: productDetails.price)
            if K.idsOfFavoriteProducts.contains(productDetails.id){
                self.addToFavoriteButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                isFavoriteitem = true
            }else{
                self.addToFavoriteButtonOutlet.setImage(UIImage(systemName: "heart"), for: .normal)
                isFavoriteitem = false
            }
            playTimer()
            networkIndicator.stopAnimating()
        }
        viewModel.failClosure = { [weak self] (errorMsg) in
            guard let self = self else {return}
            networkIndicator.stopAnimating()
            ProgressHUD.showError(errorMsg)
        }
    }
    @IBAction func addToCart(_ sender: UIButton) {
        if (K.GUEST_MOOD){
            self.confirmAlert(title: "Guest Mood",subTitle: "can't access this feature in guest mood, do you want to login/register?", imageName: K.GUEST_IMAGE, confirmBtn: "Yes,Login/Register") {
                K.GUEST_MOOD=false
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                  let viewController = storyboard.instantiateViewController(identifier: "OptionsViewController") as OptionsViewController
                viewController.modalPresentationStyle = .fullScreen
                  viewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                  self.present(viewController, animated: false, completion: nil)
            }
        }else{
            let msg = viewModel.AddToCart()
            self.view.makeToast(msg, duration: 2 ,title: "Adding to cart" ,image: UIImage(named: K.SUCCESS_IMAGE))
        }
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func navigateToReviewScreen(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ProductDetails", bundle: nil)
        let reviewVC = storyboard.instantiateViewController(withIdentifier: "ReviewsViewController") as! ReviewsViewController
        reviewVC.modalTransitionStyle = .coverVertical
        present(reviewVC, animated: true)
    }
    @IBAction func addToFavoriteButtoAction(_ sender: UIButton) {
        if (K.GUEST_MOOD){
            self.GuestMoodAlert()
        }else{
            self.favoriteButtonTapped()
        }
    }
    
}

extension ProductDetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductImageCollectionViewCell", for: indexPath) as! ProductImageCollectionViewCell
        cell.imageView.sd_setImage(with: URL(string: imagesArray[indexPath.row]), placeholderImage:UIImage(named: "test"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: productImagesCollectionView.frame.width, height: productImagesCollectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
extension ProductDetailsViewController{
    @objc func getCurrentIndex(){
        if currentIndex != imagesArray.count-1 {
            currentIndex += 1
        }else{
            currentIndex = 0
        }
        pageController.currentPage = currentIndex
        productImagesCollectionView.scrollToItem(at: IndexPath(row: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    func playTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.getCurrentIndex), userInfo: nil, repeats: true)
    }
    func favoriteButtonTapped() {
        if self.isFavoriteitem{
            confirmAlert { [weak self] in
                guard let self = self else {return}
                let msg = viewModel.removeFromFavorite()
                if msg == "Product removed successfully"{
                    self.view.makeToast(msg, duration: 2 ,title: "removing from favorites" ,image: UIImage(named: K.SUCCESS_IMAGE))
                    addToFavoriteButtonOutlet.setImage(UIImage(systemName: "heart"), for: .normal)
                    isFavoriteitem = false
                    guard let itemIndex = K.idsOfFavoriteProducts.firstIndex(of: currentItemFavoriteModel.id) else { return  }
                    K.idsOfFavoriteProducts.remove(at: itemIndex)
                }else{
                    ProgressHUD.showError(msg)
                }
            }
        }else{
            let msg = viewModel.addToFavorite()
            if msg == "Product added successfully"{
                self.view.makeToast(msg, duration: 2 ,title: "Adding to favorites" ,image: UIImage(named: K.SUCCESS_IMAGE))
                addToFavoriteButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                isFavoriteitem = true
                K.idsOfFavoriteProducts.append(currentItemFavoriteModel.id)
            }else{
                ProgressHUD.showError(msg)
            }
        }
         let initialSize = CGFloat(17)
          let expandedSize = CGFloat(25)
         UIView.animate(withDuration: 0.5, animations: {
             let originalImage = self.addToFavoriteButtonOutlet.image(for: .normal)
              let expandedImage = originalImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: expandedSize))
             self.addToFavoriteButtonOutlet.setImage(expandedImage, for: .normal)
             self.addToFavoriteButtonOutlet.layoutIfNeeded()
          }) { _ in
              UIView.animate(withDuration: 0.5, animations: {
                  let originalImage = self.addToFavoriteButtonOutlet.image(for: .normal)
                  let resizedImage = originalImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: initialSize))
                  self.addToFavoriteButtonOutlet.setImage(resizedImage, for: .normal)
                  self.addToFavoriteButtonOutlet.layoutIfNeeded()
              })
          }
    }
}
