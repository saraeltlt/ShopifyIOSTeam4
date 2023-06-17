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

    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        allFavoriteViewModel = AllFavoritesViewModel()
        print(K.USER_NAME)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allFavoriteViewModel.favoriteProducts = []
        allFavoriteViewModel.getAllSotredFavoriteItems()
        favoriteCollectionView.reloadData()
    }
}
extension FavoriteViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allFavoriteViewModel.favoriteProducts.count
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
        let storyboard = UIStoryboard(name: "ProductDetails", bundle: nil)
        let detailsVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        detailsVC.productId = allFavoriteViewModel.favoriteProducts[indexPath.row].id 
        detailsVC.modalPresentationStyle = .fullScreen
        detailsVC.modalTransitionStyle = .crossDissolve
        present(detailsVC, animated: true)
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
}
