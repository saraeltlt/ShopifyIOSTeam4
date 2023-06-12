//
//  AddressViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 06/06/2023.
//

import UIKit
protocol AddAddress{
    func addAdress(address:Address)
}

class AddressViewController: UIViewController, AddAddress {

    

    @IBOutlet weak var CheckoutBtn: UIButton!
    var navigationFlag = true
    @IBOutlet weak var addressTableView: UITableView!
    var viewModel = AddressViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        addressTableView.register(UINib(nibName: K.ADDRESS_CELL, bundle: nil), forCellReuseIdentifier: K.ADDRESS_CELL)
        setUpLeftButton()
       custmizeNavigation()

    }
    override func viewWillAppear(_ animated: Bool) {
        CheckoutBtn.isHidden = navigationFlag
        viewModel.getAllAddress()
        viewModel.gellAllAddressesObservable.bind { status in
            guard let status = status else {return}
            if status {
                DispatchQueue.main.async {
                    self.addressTableView.reloadData()
                }
            }
        }
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
    func addAdress(address: Address) {
        self.view.makeToast("Address Was added succefully", duration: 2 ,title: "Success" ,image: UIImage(named: K.SUCCESS_IMAGE))
        viewModel.getAllAddress()
        viewModel.gellAllAddressesObservable.bind { status in
            guard let status = status else {return}
            if status {
                DispatchQueue.main.async {
                    self.addressTableView.reloadData()
                }
            }
        }

    }

}
extension AddressViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section==0){
            if viewModel.getDefaultAddress()==nil{
                return 0
            }
            return 1
        }else{
            return viewModel.addressArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ADDRESS_CELL, for: indexPath) as! addressCell
        if (indexPath.section==0){
            cell.defaultBtn.isHidden=false
            cell.defaultView.isHidden=false
            cell.configure(address: viewModel.getDefaultAddress()!)
        }else{
            cell.defaultBtn.isHidden=true
            cell.defaultView.isHidden=true
            cell.configure(address: viewModel.addressArray[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section==1){
            confirmAlert(title: "Default", subTitle: "are you sure you want to set as default address?", imageName: K.ADDRESS_IMAGE , confirmBtn: "yes, set as default") {
                self.viewModel.setDefaultAddress(index: indexPath.row)
                self.addressTableView.reloadData()
            }

        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height*0.27
     }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if (indexPath.section==1){
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
                self?.confirmAlert {
                    self?.viewModel.deleteAddress(at:indexPath.row)
                    self?.addressTableView.reloadData()
                    completionHandler(true)
                }
                
            }
            
            deleteAction.backgroundColor = UIColor(named: K.ORANGE)
            
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
        }
        else{
            view.makeToast("Can't delete default address", duration: 2 ,title: "Warning" ,image: UIImage(named: K.WARNINNG_IMAGE))
            return nil
        }
    }
    
    

    
    
}
