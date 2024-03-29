//
//  LoginViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 05/06/2023.
//

import UIKit
class LoginViewController: UIViewController {
    var signInViewModel:SignInViewModel!
    var networkIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
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
    @IBOutlet weak var backButtonOutlet: UIButton!{
        didSet{
            backButtonOutlet.layer.cornerRadius = self.backButtonOutlet.bounds.width * 0.5
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        networkIndicator = UIActivityIndicatorView(style: .large)
        networkIndicator.color = UIColor(named: K.GREEN)
        networkIndicator.center = view.center
        view.addSubview(networkIndicator)
        toggleDisplayingThePasswordText()
        setScreenDefaultForm()
        signInViewModel = SignInViewModel()
        signInViewModel.failClosure = { (erreorMeg) in
            self.networkIndicator.stopAnimating()
            self.errorTitledAlert(subTitle: erreorMeg, handler: nil)
        }
        signInViewModel.successClosur = { [weak self] in
            guard let self = self else {return}
            self.setScreenDefaultForm()
            self.navigateToHomeScreen()
        }
        signInViewModel.successClosurForgetPassword = { [weak self] in
            guard let self = self else {return}
            self.errorTitledAlert(title: "Check your email", subTitle: "you can reset your passwod from an email has sent to your registered account")
        }
    }
    @IBAction func forgitePasswordAction(_ sender: UIButton) {
        if  ( InternetConnectionObservation.getInstance.internetConnection.value == true) {
            
            guard !( emailTextField.text!.isEmpty)
            else {
                self.errorTitledAlert(subTitle: "Please set the eamil", handler: nil)
                return }
            if !isValidEmail(emailTextField.text!){
                self.errorTitledAlert(subTitle: "Not valid email ..", handler: nil)
                return
            }
            signInViewModel.forgetPasswordAction(email: emailTextField.text!)
    }else {
        self.errorTitledAlert(title: "No internet Connection", subTitle: "No internet Connection please make sure to connect to 3G")
    }
    }
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func goToSignUpAction(_ sender: UIButton) {
        setScreenDefaultForm()
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let signup = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        signup.modalPresentationStyle = .fullScreen
        signup.modalTransitionStyle = .crossDissolve
        present(signup, animated: true)
    }
    @IBAction func togglePasswordVisibility(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        sender.isSelected = !passwordTextField.isSecureTextEntry
    }
    @IBAction func signInAction(_ sender: UIButton) {
        if  ( InternetConnectionObservation.getInstance.internetConnection.value == true) {
            
            guard !( emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty )
            else {
                self.errorTitledAlert(subTitle: "Fill all required information", handler: nil)
                return }
            if !isValidEmail(emailTextField.text!){
                self.errorTitledAlert(subTitle: "Not valid email ..", handler: nil)
                return
            }
            networkIndicator.startAnimating()
            signInViewModel.signInWith(email: emailTextField.text!, password: passwordTextField.text!)
    }else {
        self.errorTitledAlert(title: "No internet Connection", subTitle: "No internet Connection please make sure to connect to 3G")
    }
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func navigateToHomeScreen(){
        setScreenDefaultForm()
        let storyboard = UIStoryboard(name: "HomeStoryBoard", bundle: nil)
        let home = storyboard.instantiateViewController(identifier: "tab") as! UITabBarController
        home.modalPresentationStyle = .fullScreen
        home.modalTransitionStyle = .crossDissolve
        present(home, animated: true)
    }
    func setScreenDefaultForm(){
        networkIndicator.stopAnimating()
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    func toggleDisplayingThePasswordText(){
        passwordTextField.isSecureTextEntry = true
        passwordTextField.rightViewMode = .always

        let toggleButton = UIButton(type: .custom)
        toggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        toggleButton.setImage(UIImage(systemName: "eye"), for: .selected)
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
        toggleButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        toggleButton.tintColor = UIColor(named: K.ORANGE)
        passwordTextField.rightView = toggleButton
    }
}
