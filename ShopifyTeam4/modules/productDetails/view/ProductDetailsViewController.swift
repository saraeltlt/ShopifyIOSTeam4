//
//  ProductDetailsViewController.swift
//  ShopifyTeam4
//
//  Created by Youssef Mohamed on 10/06/2023.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    var viewModel : ProductDetailsViewModel!
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
    var imagesArrayName = ["1","2","3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        playTimer()
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension ProductDetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArrayName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductImageCollectionViewCell", for: indexPath) as! ProductImageCollectionViewCell
        cell.imageView.image = UIImage(named: imagesArrayName[indexPath.row])
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
        if currentIndex != imagesArrayName.count-1 {
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
