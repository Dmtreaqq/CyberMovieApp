//
//  LoginView.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 12.05.2023.
//

import UIKit

class LoginView: UIView {
    @IBOutlet weak var loginScreenTitleLabel: UILabel!
    @IBOutlet weak var loginImageView: UIImageView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
    func setupUI() {
        backgroundColor = Color.mainBG
        
        loginScreenTitleLabel.text = "Login to Your Account"
        loginScreenTitleLabel.textColor = .white
        
        signinButton.setTitle("Sign in", for: .normal)
        signinButton.tintColor = Color.buttonBG
        
        
        loginTextField.placeholder = "Enter your login"
        
        passwordTextField.placeholder = "Enter your password"
        passwordTextField.isSecureTextEntry = true
        
        loginImageView.image = UIImage(named: "LaunchLogo")
        loginImageView.tintColor = .white
    }
    
    func checkEmptyFields() -> Bool {
        guard let login = loginTextField.text else {
            return true
        }

        guard let password = passwordTextField.text else {
            return true
        }

        if password.isEmpty && login.isEmpty {
            return true
        }

        return false
    }
}
