//
//  ShoppingCartViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 07/06/2023.
//

import UIKit

class ShoppingCartViewController: UIViewController {
    
    @IBOutlet weak var titlePlaceHolder: UILabel!
    @IBOutlet weak var imagePlaceHolder: UIImageView!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var checkOutBtnView: UIButton!
    var viewModel = ShoppingCartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        custmizeNavigation()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.InternetConnectionStatus()
        viewModel.getCartItems()
        viewModel.getProductsObservable.bind { status in
            guard let status = status else {return}
            if status {
                DispatchQueue.main.async {
                    self.cartTableView.reloadData()
                }
                if(self.viewModel.cartProducts.isEmpty){
                    self.titlePlaceHolder.isHidden=false
                    self.imagePlaceHolder.isHidden=false
                    self.subTotalLabel.isHidden=true
                    self.checkOutBtnView.isHidden=true
                }else{
                    self.titlePlaceHolder.isHidden=true
                    self.imagePlaceHolder.isHidden=true
                    self.subTotalLabel.isHidden=false
                    self.checkOutBtnView.isHidden=false
                    self.subTotalLabel.text = "SubTotal= \(self.viewModel.subTotal) \(K.CURRENCY)"
                }
            }
            
        }
    }
    
    
    func setupTable(){
        cartTableView.register(UINib(nibName: K.CART_CELL, bundle: nil), forCellReuseIdentifier: K.CART_CELL)
        cartTableView.rowHeight = view.bounds.height*0.2
        
    }
    func custmizeNavigation(){
        let customFont = UIFont(name: "Chalkduster", size: 20)!
        let customColor = UIColor(named: K.PAIGE)!
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: customFont,
            NSAttributedString.Key.foregroundColor: customColor
        ]
        navigationItem.title = "Shopping cart"
    }
    
    @IBAction func goToCheckout(_ sender: UIButton) {
        if  (self.viewModel.internetConnection.value == true) {
            let storyboard = UIStoryboard(name: "Profile", bundle: nil)
            let viewController = storyboard.instantiateViewController(identifier: "AddressViewController") as! AddressViewController
            viewController.viewModel = viewModel.configNavigation()
            self.navigationController?.pushViewController(viewController, animated: true)
        }else {
            self.errorTitledAlert(title: "No internet Connection", subTitle: "No internet Connection please make sure to connect to 3G")
        }
        
  
    }
    

}


extension ShoppingCartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cartProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CART_CELL , for: indexPath) as! ShoppingCartCell
        let product = viewModel.getProduct(index: indexPath.row)
        cell.configure(id: product.id ,name: product.name, price: product.price, ImageUrl: product.image, itemCount: product.ItemCount, viewModel: viewModel, quantity: product.quantity, view: self.view)
          
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
                self?.confirmAlert {
                    let product = self?.viewModel.getProduct(index: indexPath.row)
                    self?.viewModel.deleteProduct(id: product!.id)
                  //  self?.cartTableView.reloadData()
                   /* self?.subTotalLabel.text = "SubTotal= \(self!.viewModel.subTotal) \(K.CURRENCY)"
                    completionHandler(true)*/
                }
                
            }
            
            deleteAction.backgroundColor = UIColor(named: K.ORANGE)   
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = rotationTransform
        cell.alpha=0
        UIView.animate(withDuration: 0.5) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha=1.0
        
        }
    }

    
    
}
