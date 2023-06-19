//
//  FavoriteViewController.swift
//  ShopifyTeam4
//
//  Created by Youssef Mohamed on 11/06/2023.
//

import UIKit
import ProgressHUD

class FavoriteViewController: UIViewController {
    var allFavoriteViewModel:AllFavoritesViewModel!

    @IBOutlet weak var noFavLabel: UILabel!
    @IBOutlet weak var noFavoriteImage: UIImageView!
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        allFavoriteViewModel = AllFavoritesViewModel()
        print(K.USER_NAME)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allFavoriteViewModel.InternetConnectionStatus()
        allFavoriteViewModel.favoriteProducts = []
        allFavoriteViewModel.getAllSotredFavoriteItems()
        favoriteCollectionView.reloadData()
        noFavoriteImage.isHidden = true
        noFavLabel.isHidden=true
        self.navigationController?.navigationBar.isHidden=true
    }

    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension FavoriteViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems =  allFavoriteViewModel.favoriteProducts.count
        if numberOfItems == 0{
            noFavoriteImage.isHidden = false
            noFavLabel.isHidden=false
        } else{
            noFavoriteImage.isHidden = true
            noFavLabel.isHidden=true
        }
        return numberOfItems
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.BRANDS_CELL, for: indexPath)
            as! BrandViewCell
            cell.addToFavorite.isHidden = false
        let product = allFavoriteViewModel.favoriteProducts[indexPath.row]
            cell.configureCell(title: product.name, imageUrl: product.image, price: product.price)
            cell.addToFavorite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.addToFavorite.isFavoriteItem = true
            cell.addToFavorite.cellIndex = indexPath.row
            cell.addToFavorite.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       if  (self.allFavoriteViewModel.internetConnection.value == true) {
            let storyboard = UIStoryboard(name: "ProductDetails", bundle: nil)
            let detailsVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
            detailsVC.productId = allFavoriteViewModel.favoriteProducts[indexPath.row].id
            detailsVC.modalPresentationStyle = .fullScreen
            detailsVC.modalTransitionStyle = .crossDissolve
            present(detailsVC, animated: true)
        } else {
            self.errorTitledAlert(title: "No internet Connection", subTitle: "No internet Connection please make sure to connect to 3G")
        }
   
        
        
    }
    @objc func buttonTapped(_ sender: FavoriteButton) {
        let currentItemFavoriteModel = allFavoriteViewModel.favoriteProducts[sender.cellIndex]
            confirmAlert { [weak self] in
                guard let self = self else {return}
                let msg = allFavoriteViewModel.removeFromFavorite(productId: currentItemFavoriteModel.id)
                if msg == "Product removed successfully"{
                    self.view.makeToast(msg, duration: 2 ,title: "removing from favorites" ,image: UIImage(named: K.SUCCESS_IMAGE))
                    allFavoriteViewModel.getAllSotredFavoriteItems()
                    self.favoriteCollectionView.reloadData()
                }else{
                    ProgressHUD.showError(msg)
                }
            }
        guard let itemIndex = K.idsOfFavoriteProducts.firstIndex(of: currentItemFavoriteModel.id) else {return }
        K.idsOfFavoriteProducts.remove(at: itemIndex)
    }
}
// UI Design Extension
extension FavoriteViewController{
    func setupUI(){
        favoriteCollectionView.register(UINib(nibName: K.BRANDS_CELL, bundle: nil), forCellWithReuseIdentifier: K.BRANDS_CELL)
        let layout = UICollectionViewCompositionalLayout { _, _ in
            return self.favSection()
        }
        favoriteCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    func favSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.35)
            ),
            subitems: [item]
        )
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 5, trailing: 12)
        
        let section = NSCollectionLayoutSection(group: group)
        return section
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
