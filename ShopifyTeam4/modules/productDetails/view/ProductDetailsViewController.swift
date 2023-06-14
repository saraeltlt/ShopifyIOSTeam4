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
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescribtionTextView: UITextView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    var timer:Timer?
    var currentIndex = 0
    var imagesArray:[String] = []
    var productId = 0
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
            self.productPriceLabel.text = productDetails.price
            self.productDescribtionTextView.text = productDetails.description
            productImagesCollectionView.reloadData()
            self.pageController.numberOfPages = imagesArray.count
            playTimer()
            networkIndicator.stopAnimating()
        }
        viewModel.failClosure = { [weak self] (errorMsg) in
            guard let self = self else {return}
            networkIndicator.stopAnimating()
            ProgressHUD.showError(errorMsg)
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
}
