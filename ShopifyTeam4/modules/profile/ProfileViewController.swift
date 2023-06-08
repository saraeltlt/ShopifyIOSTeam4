//
//  ProfileViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 06/06/2023.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var favCollection: UICollectionView!
    @IBOutlet weak var ordersTableView: UITableView!
    @IBOutlet weak var welcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersTableView.delegate=self
        ordersTableView.dataSource=self
        favCollection.delegate=self
        favCollection.dataSource=self
        let layout = UICollectionViewCompositionalLayout { _, _ in
            return self.favSection()
        }
        favCollection.setCollectionViewLayout(layout, animated: true)
        setupCells()


    }
    
    private func setupCells() {
        ordersTableView.register(UINib(nibName: K.ORDERS_CELL, bundle: nil), forCellReuseIdentifier: K.ORDERS_CELL)
        favCollection.register(UINib(nibName: "BrandViewCell", bundle: nil), forCellWithReuseIdentifier: K.brandCell)
    }
    
    
    @IBAction func moreOrdersBtn(_ sender: Any) {
    }
    
    @IBAction func moreFavBtn(_ sender: Any) {
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
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ORDERS_CELL, for: indexPath) as! OrdersCell
       cell.configure(date: "22/11/2023", price:300)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}


extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.brandCell, for: indexPath) as! BrandViewCell
        return cell
    }
    
    
}
