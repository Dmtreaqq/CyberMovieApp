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
        
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.barTintColor = Color.mainBGtab
            navigationBar.tintColor = .white
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        setupUI()
    }
    
    func setupUI() {
        tabBar.backgroundColor = Color.mainBGtab
        tabBar.tintColor = Color.buttonBG
        tabBar.barTintColor = Color.buttonBG
    }
    
    @objc func logout() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoginVC")
        navigationController?.pushViewController(vc, animated: false)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.impactOccurred(intensity: 1)
    }
}
