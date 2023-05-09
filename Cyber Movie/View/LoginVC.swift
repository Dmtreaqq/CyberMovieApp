//
//  ViewController.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 26.04.2023.
//

import UIKit
import SafariServices

class LoginVC: UIViewController {
    @IBOutlet weak var loginScreenTitleLabel: UILabel!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var loginImageView: UIImageView!
    @IBOutlet weak var loginTmdbButton: UIButton!
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
    
    
    @IBAction func loginTmdbButtonPressed(_ sender: Any) {
        let webSite = "https://dou.ua"
        
        guard let url = URL(string: webSite) else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
    
    func setupUI() {
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
}

