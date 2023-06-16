//
//  ProfileViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 06/06/2023.
//

import UIKit
import ProgressHUD

class ProfileViewController: UIViewController {

    @IBOutlet weak var favCollection: UICollectionView!
    @IBOutlet weak var ordersTableView: UITableView!
    @IBOutlet weak var welcomeLabel: UILabel!
    var viewModel = ProfileViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewCompositionalLayout { _, _ in
            return self.favSection()
        }
        favCollection.setCollectionViewLayout(layout, animated: true)
        setupCells()
        viewModel.getAllSotredFavoriteItems()

    }
    override func viewWillAppear(_ animated: Bool) {
        configureOrdersObservation()
        viewModel.getAllOrders()
        
    }
    
    private func setupCells() {
        ordersTableView.register(UINib(nibName: K.ORDERS_CELL, bundle: nil), forCellReuseIdentifier: K.ORDERS_CELL)
        favCollection.register(UINib(nibName: K.BRANDS_CELL, bundle: nil), forCellWithReuseIdentifier: K.BRANDS_CELL)
    }
    
    
    @IBAction func moreOrdersBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Orders", bundle: nil)
        let ordersVC = storyboard.instantiateViewController(withIdentifier: "OrdersViewController") as! OrdersViewController
        ordersVC.viewModel = viewModel.configureNavigationToAllOrders()
        self.navigationController?.pushViewController(ordersVC, animated: true)
    }
    
    @IBAction func moreFavBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Favorites", bundle: nil)
        let favoriteVC = storyboard.instantiateViewController(withIdentifier: "FavoriteViewController") as! FavoriteViewController
        favoriteVC.modalPresentationStyle = .popover
        favoriteVC.modalTransitionStyle = .crossDissolve
        present(favoriteVC, animated: true)
    }
    
    
    
    // MARK: - Favourite product Section

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
                heightDimension: .fractionalHeight(0.7)
            ),
            subitems: [item]
        )
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 5, trailing: 12)
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

 // MARK: - Orders section 
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func configureOrdersObservation(){
        viewModel.orders.bind { status in
            guard let status = status else {return}
            if status {
                DispatchQueue.main.async {
                    self.ordersTableView.reloadData()
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getordersCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ORDERS_CELL, for: indexPath) as! OrdersCell
        let order = viewModel.getOrderData(index: indexPath.row)
        cell.configure(date: order.created_at ?? "", price: order.current_total_price ?? "")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}


extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.favoriteProducts.count > 3{
            return 4
        }else{
            return viewModel.favoriteProducts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.BRANDS_CELL, for: indexPath)
            as! BrandViewCell
            cell.addToFavorite.isHidden = false
        let product = viewModel.favoriteProducts[indexPath.row]
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
        detailsVC.productId = viewModel.favoriteProducts[indexPath.row].id
        detailsVC.modalPresentationStyle = .fullScreen
        detailsVC.modalTransitionStyle = .crossDissolve
        present(detailsVC, animated: true)
    }
    
}
extension ProfileViewController{
    @objc func buttonTapped(_ sender: FavoriteButton) {
        let currentItemFavoriteModel = viewModel.favoriteProducts[sender.cellIndex]
        if sender.isFavoriteItem{
            confirmAlert { [weak self] in
                guard let self = self else {return}
                let msg = viewModel.removeFromFavorite(productId: currentItemFavoriteModel.id)
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
            let msg = viewModel.addToFavorite(product: currentItemFavoriteModel)
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
