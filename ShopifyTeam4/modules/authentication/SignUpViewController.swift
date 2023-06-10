//
//  SignUpViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 05/06/2023.
//

import UIKit
import ProgressHUD
class SignUpViewController: UIViewController {
    var signUpViewModel:SignUpViewModel!
    var networkIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var greenView: UIView!{
        didSet{
            greenView.layer.cornerRadius = self.greenView.bounds.width * 0.15
        }
    }
    @IBOutlet weak var whiteView: UIView!{
        didSet{
            whiteView.layer.cornerRadius = self.whiteView.bounds.width * 0.15
        }
    }
    @IBOutlet weak var scrollableWhiteView: UIView!{
        didSet{
            scrollableWhiteView.layer.cornerRadius = self.scrollableWhiteView.bounds.width * 0.15
        }
    }
    
    @IBOutlet weak var backButtonOutlet: UIButton!{
        didSet{
            backButtonOutlet.layer.cornerRadius = self.backButtonOutlet.bounds.width * 0.5
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        networkIndicator = UIActivityIndicatorView(style: .large)
        networkIndicator.color = UIColor.green
        networkIndicator.center = view.center
        view.addSubview(networkIndicator)
        signUpViewModel = SignUpViewModel()
        signUpViewModel.failClosure = { (erreorMeg) in
            ProgressHUD.showError(erreorMeg)
        }
        signUpViewModel.successClosur = { [weak self] in
            guard let self = self else {return}
            self.setScreenDefaultForm()
            self.navigateToSignInScreen()
        }
    }
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func goToSignInScreen(_ sender: UIButton) {
        navigateToSignInScreen()
    }
    @IBAction func signUpAction(_ sender: UIButton) {
        guard !(nameTextField.text!.isEmpty || emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty || confirmPasswordTextField.text!.isEmpty || phoneNumberTextField.text!.isEmpty || countryTextField.text!.isEmpty || cityTextField.text!.isEmpty || streetTextField.text!.isEmpty)
        else {
            ProgressHUD.showError("Fill all required information")
            return }
        if !isValidEmail(emailTextField.text!){
            ProgressHUD.showError("Not valid email ..")
            return
        }
        let password = passwordTextField.text!
        if  password != confirmPasswordTextField.text{
            ProgressHUD.showError("the two passwords you entered is not the same ..!")
            return
        }
        networkIndicator.startAnimating()
        let user = FUser(_objectId: "", _email: emailTextField.text!, _fullname: nameTextField.text!, _fullNumber: phoneNumberTextField.text!, _country: countryTextField.text!, _city: cityTextField.text!, _street: streetTextField.text!)
        signUpViewModel.createNewUserWith(user: user, password: password)
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    func navigateToSignInScreen(){
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let login = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        login.modalPresentationStyle = .fullScreen
        login.modalTransitionStyle = .crossDissolve
        present(login, animated: true)
    }
    func setScreenDefaultForm(){
        networkIndicator.stopAnimating()
        nameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
        phoneNumberTextField.text = ""
        countryTextField.text = ""
        cityTextField.text = ""
        streetTextField.text  = ""
    }
}
