//
//  LoginViewController.swift
//  Instagram
//
//  Created by Andrei Mosneag on 07.06.2022.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    struct Constantants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = " Username or Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView (frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constantants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = " Pasword"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView (frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constantants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor

        return field    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constantants.cornerRadius
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of services", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privaci political", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("New Uset? Create an Account", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let headet =  UIView()
        let backgraundImageView = UIImageView(image: UIImage(named: "gradient"))
        headet.clipsToBounds = true
        headet.addSubview(backgraundImageView)
        return headet
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self,
                              action: #selector(didTapLogButton),
                              for: .touchUpInside)
        createAccountButton.addTarget(self,
                              action: #selector(didTapCreateAccountButton),
                              for: .touchUpInside)
        termsButton.addTarget(self,
                              action: #selector(didTapTermsButton),
                              for: .touchUpInside)
        privacyButton.addTarget(self,
                              action: #selector(didTapPrivacyButton),
                              for: .touchUpInside)
        
        
        usernameEmailField.delegate = self
        passwordField.delegate = self
        
         addSubviews()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(
            x: 0,
            y: 0.0,
            width: view.width  ,
            height: view.height / 3.0
        )
        
        usernameEmailField.frame = CGRect(
            x: 25,
            y: headerView.bottom + 20,
            width: view.width-50  ,
            height: 52
        )
        
        passwordField.frame = CGRect(
            x: 25,
            y: usernameEmailField.bottom + 10,
            width: view.width-50  ,
            height: 52
        )
        
        loginButton.frame = CGRect(
            x: 25,
            y: passwordField.bottom + 10,
            width: view.width-50  ,
            height: 52
        )
        
        createAccountButton.frame = CGRect(
            x: 25,
            y: loginButton.bottom + 10,
            width: view.width-50  ,
            height: 52
        )
        
        loginButton.frame = CGRect(
            x: 25,
            y: passwordField.bottom + 10,
            width: view.width-50  ,
            height: 52
        )
        
        privacyButton.frame = CGRect(
            x: 10,
            y: view.height - view.safeAreaInsets.bottom - 70 ,
            width: view.width-20  ,
            height: 52
        )
        
        termsButton.frame = CGRect(
            x: 10,
            y: view.height - view.safeAreaInsets.bottom - 100,
            width: view.width-20  ,
            height: 52
        )
    
        configureHeaderView()
    }
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else {
            return
        }
        
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        
        // Add instagram logo
        let imageView = UIImageView(image: UIImage(named: "logo"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.width/2.0,
                                 height: headerView.height - view.safeAreaInsets.top)
    }
    
    
    private func addSubviews() {
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(headerView)
        view.addSubview(createAccountButton)

    }
    
    @objc private func didTapLogButton() {
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8
        else {
            return
        }
        // login functionality
        
        var username: String?
        var email: String?
        
        
        if usernameEmail.contains("@"), usernameEmail.contains("."){
            //email
            email = usernameEmail
        }else{
            //username
            username = usernameEmail
        }
        
        AuthManager.shared.loginUser(username: username, email: email, password: password)  { success in
            DispatchQueue.main.async {
                if success {
                    // log in
                    self.dismiss(animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Log in error",
                                                  message: "We were unable to log you in.",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss",
                                                  style: .cancel,
                                                  handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
        
    }
    @objc private func didTapTermsButton() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870")else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
    }
    @objc private func didTapPrivacyButton() {
        guard let url = URL(string: "https://help.instagram.com/196883487377501")else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    @objc private func didTapCreateAccountButton() {
          let vc = RegisterViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }

    

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        }
        else if  textField == passwordField {
            didTapLogButton()
        }
        return true
}
}
