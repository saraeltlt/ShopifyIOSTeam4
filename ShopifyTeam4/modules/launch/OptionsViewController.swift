//
//  OptionsViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 04/06/2023.
//

import UIKit

class OptionsViewController: UIViewController {

    @IBAction func goToHomeBtn(_ sender: UIButton) {
         let storyboard = UIStoryboard(name: "HomeStoryBoard", bundle: nil)
         let home = storyboard.instantiateViewController(identifier: "tab") as! UITabBarController
         home.modalPresentationStyle = .fullScreen
         home.modalTransitionStyle = .crossDissolve
         present(home, animated: true)

    }

    @IBAction func goToSignupBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let signup = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        signup.modalPresentationStyle = .fullScreen
        signup.modalTransitionStyle = .crossDissolve
        present(signup, animated: true)

    }
    @IBAction func goToLoginBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let login = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        login.modalPresentationStyle = .fullScreen
        login.modalTransitionStyle = .crossDissolve
        present(login, animated: true)

    }
}

