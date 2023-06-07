//
//  AddressViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 06/06/2023.
//

import UIKit

class AddressViewController: UIViewController {

    @IBOutlet weak var addressTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        setUpLeftButton()
    }
    
    func setUpTable(){
        addressTableView.delegate=self
        addressTableView.dataSource=self
        addressTableView.register(UINib(nibName: K.ADDRESS_CELL, bundle: nil), forCellReuseIdentifier: K.ADDRESS_CELL)
        
    }
    func setUpLeftButton(){
       let rightBtn = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addButtonTapped)
        )
        rightBtn.tintColor = UIColor(named: K.lightOrange)
        navigationItem.rightBarButtonItem = rightBtn
    }
    @objc func addButtonTapped() {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "AddAddressViewController") as AddAddressViewController
        viewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        viewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(viewController, animated: false, completion: nil)
    }

}
extension AddressViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ADDRESS_CELL, for: indexPath) as! addressCell
        cell.configure()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height*0.2
     }

    
    
}
