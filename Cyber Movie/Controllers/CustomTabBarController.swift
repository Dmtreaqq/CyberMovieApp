//
//  MainTabBar.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 28.04.2023.
//

import UIKit



class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        
    }
    
    @objc func logout() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoginVC")
        navigationController?.pushViewController(vc, animated: false)
    }
}
