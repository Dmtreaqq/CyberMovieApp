//
//  ViewController.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 26.04.2023.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var loginScreenTitleLabel: UILabel!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var loginImageView: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
                
        setupUI()
    }
    
    @IBAction func signinButtonPressed(_ sender: Any) {
        let sb = UIStoryboard(name: "Movies", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CustomTabBarController")
        
        let isFieldsEmpty = checkEmptyFields()
        
        if isFieldsEmpty {
            let alert = UIAlertController(title: "Warning", message: "Enter something in one of fields", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(action)
            present(alert, animated: true)
        } else {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func setupUI() {
        loginTextField.delegate = self
        
        view.backgroundColor = Color.mainBG
        
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

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

