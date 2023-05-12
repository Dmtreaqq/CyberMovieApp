//
//  ViewController.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 26.04.2023.
//

import UIKit

class LoginVC: UIViewController {
    private var loginView: LoginView! {
        guard isViewLoaded else { return nil }
        return (view as! LoginView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
                
        setupUI()
    }
    
    @IBAction func signinButtonPressed(_ sender: Any) {
        let sb = UIStoryboard(name: "Movies", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CustomTabBarController")
        
        let isFieldsEmpty = loginView.checkEmptyFields()
        
        if isFieldsEmpty {
            let alert = UIAlertController(title: "Warning", message: "Enter something in one of fields", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(action)
            present(alert, animated: true)
        } else {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

private extension LoginVC {
    func setupUI() {
        loginView.loginTextField.delegate = self
        loginView.setupUI()
    }
}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

