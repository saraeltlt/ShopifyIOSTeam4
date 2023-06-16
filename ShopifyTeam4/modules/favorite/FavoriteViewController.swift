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
    var allfavoriteProductsArray:[ProductFavorite] = []
    @IBOutlet weak var backButtonOutlet: UIButton!{
        didSet{
            backButtonOutlet.layer.cornerRadius = backButtonOutlet.bounds.width * 0.5
        }
    }
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        allFavoriteViewModel = AllFavoritesViewModel()
        allFavoriteViewModel.getAllSotredFavoriteItems()
        allFavoriteViewModel.successClosure = { favoriteProducts in
            self.allfavoriteProductsArray = favoriteProducts
            self.favoriteCollectionView.reloadData()
            print("in succes closure with \(self.allfavoriteProductsArray)")
        }
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
extension FavoriteViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allFavoriteViewModel.favoriteProducts.count
        //return allfavoriteProductsArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.BRANDS_CELL, for: indexPath)
            as! BrandViewCell
            cell.addToFavorite.isHidden = false
        let product = allFavoriteViewModel.favoriteProducts[indexPath.row]
            cell.configureCell(title: product.name, imageUrl: product.image, price: product.price)
            if K.idsOfFavoriteProducts.contains(product.id){
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
        if sender.isFavoriteItem{
            confirmAlert { [weak self] in
                guard let self = self else {return}
                let msg = allFavoriteViewModel.removeFromFavorite(productId: currentItemFavoriteModel.id)
                if msg == "Product removed successfully"{
                    self.view.makeToast(msg, duration: 2 ,title: "removing to favorites" ,image: UIImage(named: K.SUCCESS_IMAGE))
                    sender.setImage(UIImage(systemName: "heart"), for: .normal)
                    sender.isFavoriteItem = false
                    guard let itemIndex = K.idsOfFavoriteProducts.firstIndex(of: currentItemFavoriteModel.id) else { return  }
                    K.idsOfFavoriteProducts.remove(at: itemIndex)
                }else{
                    ProgressHUD.showError(msg)
                }
            }
        }else{
            let msg = allFavoriteViewModel.addToFavorite(product: currentItemFavoriteModel)
            if msg == "Product added successfully"{
                self.view.makeToast(msg, duration: 2 ,title: "Adding to favorites" ,image: UIImage(named: K.SUCCESS_IMAGE))
                sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                sender.isFavoriteItem = true
                K.idsOfFavoriteProducts.append(currentItemFavoriteModel.id)
            }else{
                ProgressHUD.showError(msg)
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
                heightDimension: .fractionalHeight(0.4)
            ),
            subitems: [item]
        )
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 5, trailing: 12)
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
