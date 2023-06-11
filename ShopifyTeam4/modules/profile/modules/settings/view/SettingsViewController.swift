//
//  SettingsViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 06/06/2023.
//

import UIKit

protocol UpdateData{
    func reloadTable()
}



class SettingsViewController: UIViewController, UpdateData {

    @IBAction func logOut(_ sender: UIButton) {
        UserDefaults.standard.set(nil, forKey: kCURRENTUSER)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let viewController = storyboard.instantiateViewController(identifier: "OptionsViewController") as OptionsViewController
          viewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
          viewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
          self.present(viewController, animated: false, completion: nil)
    }
    
    
    @IBOutlet weak var settingsTable: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupTable()

    }
    func setupTable(){
        settingsTable.register(UINib(nibName: K.SETTINGS_CELL, bundle: nil), forCellReuseIdentifier: K.SETTINGS_CELL)
        settingsTable.rowHeight = view.bounds.height*0.1
    }
    func reloadTable() {
        settingsTable.reloadData()
    }
    
    


    

}


extension SettingsViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.SETTINGS_CELL) as! SettingsCell
        cell.configure(index:indexPath.row)
        
        return cell
        
    
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        switch indexPath.row{
        case 0:
            let viewController = storyboard.instantiateViewController(identifier: "AddressViewController")
            self.navigationController?.pushViewController(viewController, animated: true)
        case 1:
            let viewController = storyboard.instantiateViewController(identifier: "CurrencyViewController") as! CurrencyViewController
            viewController.delegate = self
            viewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            viewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(viewController, animated: false, completion: nil)
        case 2:
            let viewController = storyboard.instantiateViewController(identifier: "ContactUpViewController")
            self.navigationController?.pushViewController(viewController, animated: true)
        case 3:
            let viewController = storyboard.instantiateViewController(identifier: "AboutUsViewController")
            self.navigationController?.pushViewController(viewController, animated: true)
        default:
            print("HEY")
        }
    }

    
    
}
