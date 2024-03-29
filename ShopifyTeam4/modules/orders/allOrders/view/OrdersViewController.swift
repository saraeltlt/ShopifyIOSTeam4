//
//  OrdersViewController.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 11/06/2023.
//

import UIKit

class OrdersViewController: UIViewController {
    
    @IBOutlet weak var ordersTable: UITableView!
    var viewModel:OrdersViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersTable.register(UINib(nibName: K.ORDERS_CELL, bundle: nil), forCellReuseIdentifier: K.ORDERS_CELL)
        custmizeNavigation()
    }
    
    func custmizeNavigation(){
        let customFont = UIFont(name: "Chalkduster", size: 20)!
        let customColor = UIColor(named: K.PAIGE)!
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: customFont,
            NSAttributedString.Key.foregroundColor: customColor
        ]
        navigationItem.title = "Orders"
    }}


// MARK: - Orders Table

extension OrdersViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getordersCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ORDERS_CELL, for: indexPath) as! OrdersCell
        let order = viewModel?.getOrderData(index: indexPath.row)
        cell.configure(date: order?.created_at ?? "", price: order?.current_total_price ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderDetails = (self.storyboard?.instantiateViewController(withIdentifier: "orderDetails") as? OrderDetailsViewController)!
        orderDetails.viewModel = viewModel?.configureNavigationToOrderDetails(index: indexPath.row)
        self.navigationController?.pushViewController(orderDetails, animated: true)
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
        cell.layer.transform = rotationTransform
        cell.alpha=0.5
        UIView.animate(withDuration: 1.0) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha=1.0
        }
    }
    
}

