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
        
        view.backgroundColor = UIColor(red: 15/255, green: 27/255, blue: 43/255, alpha: 1)
        
        setupUI()
    }

    @IBAction func signinButtonPressed(_ sender: Any) {
        print("User logged in")
    }
    
    func setupUI() {
        loginScreenTitleLabel.text = "Login to Your Account"
        loginScreenTitleLabel.textColor = .white
        
        signinButton.setTitle("Sign in", for: .normal)
        
        loginTextField.placeholder = "Enter your login"
        
        passwordTextField.placeholder = "Enter your password"
        passwordTextField.isSecureTextEntry = true
        
        loginImageView.image = UIImage(named: "LaunchLogo")
        loginImageView.tintColor = .white
    }
}

