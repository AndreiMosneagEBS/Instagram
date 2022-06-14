//
//  RegisterViewController.swift
//  Instagram
//
//  Created by Andrei Mosneag on 07.06.2022.
//

import UIKit

class RegisterViewController: UIViewController {
    
    struct Constantants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = " Username... "
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
    
    private let emaiField: UITextField = {
        let field = UITextField()
        field.placeholder = " Email.... "
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
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constantants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.addTarget(self,
                                 action: #selector(didTapRegister),
                                 for: .touchUpInside)
        
        view.addSubview(usernameField)
        view.addSubview(emaiField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        usernameField.delegate = self
        emaiField.delegate = self
        passwordField.delegate = self

        view.backgroundColor = .systemBackground
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        usernameField.frame = CGRect(x: 20,
                                     y: view.safeAreaInsets.top + 40,
                                     width: view.width - 40 ,
                                     height: 52)
        
        emaiField.frame = CGRect(x: 20,
                                 y: usernameField.bottom + 10,
                                  width: view.width - 40 ,
                                  height: 52)
        
        passwordField.frame = CGRect(x: 20,
                                     y: emaiField.bottom + 10,
                                     width: view.width - 40 ,
                                     height: 52)
                                 
        registerButton.frame = CGRect(x: 20,
                                      y: passwordField.bottom + 10,
                                      width: view.width - 40 ,
                                      height: 52)

    }
    @ objc private func didTapRegister(){
        emaiField.resignFirstResponder()
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let email = emaiField.text, !email.isEmpty,
              let username = usernameField.text, !username.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registed in
            DispatchQueue.main.async {
                if registed {
                   //go to goo
                }else{
                    //show alert
                }
            }
        }
    }

}
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emaiField.becomeFirstResponder()
        }
        else if textField == emaiField{
            passwordField.becomeFirstResponder()
        }
        else {
            didTapRegister()
        }
        return true
    }
}
