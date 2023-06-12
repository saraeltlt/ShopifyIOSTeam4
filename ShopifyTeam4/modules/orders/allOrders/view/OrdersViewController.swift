//
//  OrdersViewController.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 11/06/2023.
//

import UIKit
import RealmSwift

class OrdersViewController: UIViewController {
    
    @IBOutlet weak var ordersTable: UITableView!
    
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
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ORDERS_CELL, for: indexPath) as! OrdersCell
       cell.configure(date: "22/11/2023", price:300)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderDetails = (self.storyboard?.instantiateViewController(withIdentifier: "orderDetails") as? OrderDetailsViewController)!
        self.navigationController?.pushViewController(orderDetails, animated: true)
        
        
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL)
      /*  let person = Person()
        person.age = "25"
        person.name = "eslam"
        person.phone = "01226478930"
        try! realm.write{
            realm.add(person)
        }*/
        let people = realm.objects(Person.self)
        print(people)
        
    }
    
}


class Person:Object{
    @objc dynamic var name:String?
    @objc dynamic var phone:String?
    @objc dynamic var age:String?
    
}
