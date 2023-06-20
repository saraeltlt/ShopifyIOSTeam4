//
//  SignUpViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 05/06/2023.
//

import UIKit
class SignUpViewController: UIViewController {
    var signUpViewModel:SignUpViewModel!
    var networkIndicator: UIActivityIndicatorView!
    var storedPhoneNumbers:[String] = []
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var countryTextField: DropDown!{
        didSet{
            self.countryTextField.optionArray = K.generateCountries()
            self.countryTextField.selectedRowColor = UIColor(named: K.LIGHT_ORANGE)!
        }
    }
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
        networkIndicator.color = UIColor(named: K.GREEN)
        networkIndicator.center = view.center
        view.addSubview(networkIndicator)
        toggleDisplayingThePasswordText()
        signUpViewModel = SignUpViewModel()
        signUpViewModel.getStoredPhoneNumber()
        setScreenDefaultForm()
        signUpViewModel.failClosure = { (erreorMeg) in
            DispatchQueue.main.async {
                self.networkIndicator.stopAnimating()
                self.errorTitledAlert(subTitle: erreorMeg, handler: nil)
            }

        }
        signUpViewModel.successClosur = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.storedPhoneNumbers.append(self.passwordTextField.text!)
                self.navigateToSignInScreen()
                
            }
        }
        signUpViewModel.phoneNumberClosure = { [weak self] (phoneNumbers)  in
            guard let self = self else {return}
            self.storedPhoneNumbers = phoneNumbers
            print("number of stored number is \(storedPhoneNumbers.count)")
        }
    }
    @IBAction func togglePasswordVisibility(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        sender.isSelected = !passwordTextField.isSecureTextEntry
    }
    @IBAction func toggleConfirmPasswordVisibility(_ sender: UIButton) {
        confirmPasswordTextField.isSecureTextEntry.toggle()
        sender.isSelected = !confirmPasswordTextField.isSecureTextEntry
    }
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func goToSignInScreen(_ sender: UIButton) {
        navigateToSignInScreen()
    }
    @IBAction func signUpAction(_ sender: UIButton) {
        if  ( InternetConnectionObservation.getInstance.internetConnection.value == true) {
        guard !(nameTextField.text!.isEmpty || emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty || confirmPasswordTextField.text!.isEmpty || phoneNumberTextField.text!.isEmpty || countryTextField.text!.isEmpty || cityTextField.text!.isEmpty || streetTextField.text!.isEmpty)
        else {
            errorTitledAlert(subTitle: "Fill all required information \n can't continue with empty fields", handler: nil)
            return }
        if !isValidEmail(emailTextField.text!){
            errorTitledAlert(subTitle: "Not valid email ..\n try aagain", handler: nil)
            return
        }
        
        let password = passwordTextField.text!
        if !validatePassword(password){
            notTitledCustomAlert(title: "The password is very weak", subTitle: "it should contains at least 8 characters, numbers, upper cased & special characters ", handler: nil)
            return
        }
        if  password != confirmPasswordTextField.text{
            errorTitledAlert(subTitle: "the two passwords you entered is not the same ..!", handler: nil)
            return
        }
        if !isValidPhoneNumber(phoneNumberTextField.text!){
            errorTitledAlert(subTitle: "Not valid phone number ..!, \n try aagain", handler: nil)
            return
        }
        if storedPhoneNumbers.contains(phoneNumberTextField.text!){
            notTitledCustomAlert(title: "duplicated phone number", subTitle: "This number is already assigned to another user", handler: nil)
            return
        }
        networkIndicator.startAnimating()
        let user = FUser(_objectId: "", _email: emailTextField.text!, _fullname: nameTextField.text!, _fullNumber: phoneNumberTextField.text!, _country: countryTextField.text!, _city: cityTextField.text!, _street: streetTextField.text!)
        signUpViewModel.createNewUserWith(user: user, password: password)
        }else {
            self.errorTitledAlert(title: "No internet Connection", subTitle: "No internet Connection please make sure to connect to 3G")
        }
        
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    func navigateToSignInScreen(){
        setScreenDefaultForm()
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
    func toggleDisplayingThePasswordText(){
        passwordTextField.isSecureTextEntry = true
        passwordTextField.rightViewMode = .always
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.rightViewMode = .always
        
        let toggleButton = UIButton(type: .custom)
        toggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        toggleButton.setImage(UIImage(systemName: "eye"), for: .selected)
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
        toggleButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        toggleButton.tintColor = UIColor(named: K.ORANGE)
        passwordTextField.rightView = toggleButton
        
        let toggleButton2 = UIButton(type: .custom)
        toggleButton2.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        toggleButton2.setImage(UIImage(systemName: "eye"), for: .selected)
        toggleButton2.addTarget(self, action: #selector(toggleConfirmPasswordVisibility(_:)), for: .touchUpInside)
        toggleButton2.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        toggleButton2.tintColor = UIColor(named: K.ORANGE)
        confirmPasswordTextField.rightView = toggleButton2
    }
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
            let digitPattern = #"^\d+$"#
            let digitRegex = try! NSRegularExpression(pattern: digitPattern)
            let phonePattern = #"^\+?\d{1,3}?[-.\s]?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}$"#
            let phoneRegex = try! NSRegularExpression(pattern: phonePattern)
            let isDigitOnly = digitRegex.matches(in: phoneNumber, range: NSRange(location: 0, length: phoneNumber.count)).count > 0
            let isPhoneNumberValid = phoneRegex.matches(in: phoneNumber, range: NSRange(location: 0, length: phoneNumber.count)).count > 0
            return isDigitOnly && isPhoneNumberValid
        }
    func validatePassword(_ password: String) -> Bool{
               let passwordreg =  ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&*_-]).{8,}")
                let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
                return passwordtesting.evaluate(with: password)
    }
}
