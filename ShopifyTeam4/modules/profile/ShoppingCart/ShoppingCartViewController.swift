//
//  ShoppingCartViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 07/06/2023.
//

import UIKit

class ShoppingCartViewController: UIViewController {

    @IBOutlet weak var cartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        custmizeNavigation()
    }
    
    
    func setupTable(){
        cartTableView.dataSource=self
        cartTableView.delegate=self
        cartTableView.register(UINib(nibName: K.CART_CELL, bundle: nil), forCellReuseIdentifier: K.CART_CELL)
        cartTableView.rowHeight = view.bounds.height*0.2
        
    }
    func custmizeNavigation(){
        let customFont = UIFont(name: "Chalkduster", size: 20)!
        let customColor = UIColor(named: K.paige)!
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: customFont,
            NSAttributedString.Key.foregroundColor: customColor
        ]
        navigationItem.title = "Shopping cart"
    }
    
    @IBAction func goToCheckout(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
            let viewController = storyboard.instantiateViewController(identifier: "AddressViewController") as! AddressViewController
        viewController.navigationFlag = false
            self.navigationController?.pushViewController(viewController, animated: true)
        
        
        
    }
    

}


extension ShoppingCartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CART_CELL , for: indexPath) as! ShoppingCartCell
        cell.configure(name: "Bag", price: 300, ImageUrl: "")
        return cell
    }
    
    
}
