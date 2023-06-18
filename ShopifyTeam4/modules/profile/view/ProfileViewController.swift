//
//  ProfileViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 06/06/2023.
//

import UIKit
import Lottie

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var shoppingCartCount: UIBarButtonItem!
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var noOrders: UIButton!
    @IBOutlet weak var noWishlist: UIButton!
    @IBOutlet weak var guestView: UIView!
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
        viewModel.successClosure = {
            self.favCollection.reloadData()
        }
        
        
    }
    @IBAction func goToLogin(_ sender: UIButton) {
        K.GUEST_MOOD=false
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let viewController = storyboard.instantiateViewController(identifier: "OptionsViewController") as OptionsViewController
        viewController.modalPresentationStyle = .fullScreen
          viewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
          self.present(viewController, animated: false, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        if (K.GUEST_MOOD){
            guestView.isHidden=false
            self.navigationController?.navigationBar.isHidden=true
            animationView.animationSpeed=1.5
            animationView.loopMode = .loop
            animationView.play()
        }else{
            welcomeLabel.text="Welcome \(K.USER_NAME)"
            guestView.isHidden=true
            self.navigationController?.navigationBar.isHidden=false
            configureOrdersObservation()
            configureShoppingCartCountObservation()
            viewModel.getAllSotredShoppingCardItems()
            viewModel.favoriteProducts = []
            viewModel.getAllOrders()
            viewModel.getAllSotredFavoriteItems()
            favCollection.reloadData()
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        animationView.stop()
    }
    private func setupCells() {
        ordersTableView.register(UINib(nibName: K.ORDERS_CELL, bundle: nil), forCellReuseIdentifier: K.ORDERS_CELL)
        favCollection.register(UINib(nibName: K.BRANDS_CELL, bundle: nil), forCellWithReuseIdentifier: K.BRANDS_CELL)
    }
    
    func configureShoppingCartCountObservation(){
        viewModel.CartItemsCount.bind { count in
            guard let count = count else {return}
                if let view = self.shoppingCartCount.value(forKey: "view") as? UIView {
                    if count > 0 {
                        view.addBadge(text: "\(count)",color: K.GREEN)
                    }else {
                        view.removeBadge()
                    }
                   }
            
        }
    }
    
    @IBAction func moreOrdersBtn(_ sender: Any) {
        if (viewModel.getordersCount() == 0){
            self.view.makeToast("No more orders to show", duration: 2 ,title: "Warning" ,image: UIImage(named: K.WARNINNG_IMAGE))
        } else {
            
            
            let storyboard = UIStoryboard(name: "Orders", bundle: nil)
            let ordersVC = storyboard.instantiateViewController(withIdentifier: "OrdersViewController") as! OrdersViewController
            ordersVC.viewModel = viewModel.configureNavigationToAllOrders()
            self.navigationController?.pushViewController(ordersVC, animated: true)
        }
        
    }
    
    @IBAction func moreFavBtn(_ sender: Any) {
        if (viewModel.getFavoritesCount() == 0){
            self.view.makeToast("No more favorites to show", duration: 2 ,title: "Warning" ,image: UIImage(named: K.WARNINNG_IMAGE))
        }else {
            let storyboard = UIStoryboard(name: "Favorites", bundle: nil)
            let favoriteVC = storyboard.instantiateViewController(withIdentifier: "FavoriteViewController") as! FavoriteViewController
            self.navigationController?.pushViewController(favoriteVC, animated: true)
        }
        
        
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
                heightDimension: .fractionalHeight(0.5)
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
        let rowCount = viewModel.getordersCount()
        if rowCount==0{
            noOrders.isHidden=false
        }else{
            noOrders.isHidden=true
        }
        return rowCount
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
        let itemsCount = viewModel.favoriteProducts.count
        
        
        if itemsCount > 3{
            return 4
        }else{
            if itemsCount==0{
                noWishlist.isHidden=false
            }else{
                noWishlist.isHidden=true
            }
            return itemsCount
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.BRANDS_CELL, for: indexPath)
        as! BrandViewCell
        cell.addToFavorite.isHidden = false
        let product = viewModel.favoriteProducts[indexPath.row]
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
        detailsVC.productId = viewModel.favoriteProducts[indexPath.row].id
        detailsVC.modalPresentationStyle = .fullScreen
        detailsVC.modalTransitionStyle = .crossDissolve
        present(detailsVC, animated: true)
    }
    
}
extension ProfileViewController{
    @objc func buttonTapped(_ sender: FavoriteButton) {
        let currentItemFavoriteModel = viewModel.favoriteProducts[sender.cellIndex]
        confirmAlert { [weak self] in
            guard let self = self else {return}
            let msg = viewModel.removeFromFavorite(productId: currentItemFavoriteModel.id)
            if msg == "Product removed successfully"{
                self.view.makeToast(msg, duration: 2 ,title: "removing from favorites" ,image: UIImage(named: K.REMOVE_IMAGE))
                viewModel.getAllSotredFavoriteItems()
                self.favCollection.reloadData()
            }else{
                self.errorTitledAlert(subTitle: msg, handler: nil)
            }
        }
        guard let itemIndex = K.idsOfFavoriteProducts.firstIndex(of: currentItemFavoriteModel.id) else {return }
        K.idsOfFavoriteProducts.remove(at: itemIndex)
    }
}
