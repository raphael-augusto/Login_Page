//
//  ViewController.swift
//  Login
//
//  Created by Raphael Augusto on 04/08/22.
//

import UIKit

class LoginViewController: UIViewController {

    let titleHome           = GFTitleLabel(name: "Courier-Bold", fontSize: 35)
    let emailTextField      = GFTextField(placeholder: "E-mail", keyboardType: .emailAddress)
    let passwordTextField   = GFTextField(placeholder: "Password", keyboardType: .default)
    let loginButton         = GFButton(color: UIColor(red: 0.276, green: 0.388, blue: 0.946, alpha: 1), title: "Login", systemImageName: "person.crop.circle")
    let forgotButton        = GFButton(color: UIColor.black.withAlphaComponent(0.0), title: "Forgot password?", systemImageName: nil)
    let registeTitle        = GFTitleLabel(name: "Courier-Regular", fontSize: 18)
    let registerButton      = GFButton(color: UIColor.black.withAlphaComponent(0.0), title: "SIGN UP", systemImageName: nil)

    var isEmailEntered: Bool { return !emailTextField.text!.isEmpty }
    var isPasswordEntered: Bool { return !passwordTextField.text!.isEmpty }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configure()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    
    private func configureView() {
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [
            UIColor(red: 0.040, green: 0.066, blue: 0.97, alpha: 1).cgColor,
            UIColor(red: 0.039, green: 0.047, blue: 0.09, alpha: 1).cgColor
        ]
        
        gradient.locations  = [0.0 , 0.5]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint   = CGPoint(x: 1.0, y: 1.0)
        gradient.frame      = CGRect(x: 1.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    
    private func configure() {
        createDismissKeyboardTapGesture()
        
        configureTitle()
        configureTextField()
        configureButton()
    }
    
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    private func configureTitle() {
        view.addSubview(titleHome)
        view.addSubview(registeTitle)
        
        titleHome.text      = "Login"
        registeTitle.text   = "Don't have a account?"
        
        NSLayoutConstraint.activate([
            titleHome.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 190),
            titleHome.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            registeTitle.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            registeTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 80),
        ])
    }
    
    
    private func configureTextField() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        
        emailTextField.textContentType              = .emailAddress
        emailTextField.returnKeyType                = .next
        emailTextField.autocapitalizationType       = .none
        emailTextField.delegate                     = self

        
        passwordTextField.textContentType           = .password
        passwordTextField.returnKeyType             = .done
        passwordTextField.autocapitalizationType    = .none
        passwordTextField.isSecureTextEntry         = true
        passwordTextField.delegate                  = self
        
        let padding:CGFloat = 24
        let height:CGFloat  = 60
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: titleHome.bottomAnchor, constant: 100),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            emailTextField.heightAnchor.constraint(equalToConstant: height),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 12),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            passwordTextField.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func configureButton() {
        view.addSubview(loginButton)
        view.addSubview(forgotButton)
        view.addSubview(registerButton)
        
        registerButton.configuration?.baseForegroundColor  = UIColor(red: 70/245, green: 99/245, blue: 241/245, alpha: 1)
        
        loginButton.addTarget(self, action: #selector(didTapActionButtonLogin), for: .touchUpInside)
        forgotButton.addTarget(self, action: #selector(didTapActionButtonForgotpassword), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(didTapActionButtonRegister), for: .touchUpInside)
        
        let padding:CGFloat = 24
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: padding),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            forgotButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            forgotButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            
            registerButton.leadingAnchor.constraint(equalTo: registeTitle.trailingAnchor),
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
        ])
    }
    
}


//MARK: -- UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        
        return true
    }
}


//MARK: -- ActionButton
extension LoginViewController {
    
    @objc func didTapActionButtonLogin() {
        guard isEmailEntered else {
            presentGFAlert(title: "Empty email", message: "Please enter a email. We need to know the email to enter 😄.", buttonTitle: "Ok")
            return
        }
        
        guard isPasswordEntered else {
            presentGFAlert(title: "Empty password", message: "Please enter a password. We need to know the password to enter 😄.", buttonTitle: "Ok")
            return
        }
        
        print("APERTOU -> Entrar")
    }
    
    
    @objc func didTapActionButtonForgotpassword() {
        print("APERTOU -> Esqueceu a senha")
    }
    
    
    @objc func didTapActionButtonRegister() {
        print("APERTOU -> registrar")
    }
}
