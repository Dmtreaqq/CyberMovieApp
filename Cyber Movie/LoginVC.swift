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
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupUI() {
        view.backgroundColor = Color.mainBG
        
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

