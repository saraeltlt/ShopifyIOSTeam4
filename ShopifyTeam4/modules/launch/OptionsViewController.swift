//
//  OptionsViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 04/06/2023.
//

import UIKit

class OptionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToHomeBtn(_ sender: UIButton) {
        print("will navigatehyy")
        let storyboard = UIStoryboard(name: "HomeStoryBoard", bundle: nil)
        let home = storyboard.instantiateViewController(identifier: "tab") as! UITabBarController
        home.modalPresentationStyle = .fullScreen
        home.modalTransitionStyle = .crossDissolve
        present(home, animated: true)
        
        
    }

}
