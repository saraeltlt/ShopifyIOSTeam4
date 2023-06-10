//
//  AddressViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 06/06/2023.
//

import UIKit
protocol AddAddress{
    func addAdress(address:String , phoneNumber: String)
}

class AddressViewController: UIViewController, AddAddress {

    @IBOutlet weak var CheckoutBtn: UIButton!
    var navigationFlag = true
    @IBOutlet weak var addressTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addressTableView.register(UINib(nibName: K.ADDRESS_CELL, bundle: nil), forCellReuseIdentifier: K.ADDRESS_CELL)
        setUpLeftButton()
        custmizeNavigation()

    }
    override func viewWillAppear(_ animated: Bool) {
        CheckoutBtn.isHidden = navigationFlag
    }
    func custmizeNavigation(){
        let customFont = UIFont(name: "Chalkduster", size: 20)!
        let customColor = UIColor(named: K.PAIGE)!
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: customFont,
            NSAttributedString.Key.foregroundColor: customColor
        ]
        navigationItem.title = "Address"
    }

    func setUpLeftButton(){
       let rightBtn = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addButtonTapped)
        )
        rightBtn.tintColor = UIColor(named: K.LIGHT_ORANGE)
        navigationItem.rightBarButtonItem = rightBtn
    }
    @objc func addButtonTapped() {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "AddAddressViewController") as AddAddressViewController
        viewController.delegate = self
        viewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        viewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(viewController, animated: false, completion: nil)
    }
    
    func addAdress(address: String, phoneNumber: String) {
       // viewModel.addressArray = address
        addressTableView.reloadData()
    }

}
extension AddressViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ADDRESS_CELL, for: indexPath) as! addressCell
        cell.configure(phoneNum: "01206425318", Address: "Alexandria - louran")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height*0.27
     }

    
    
}
