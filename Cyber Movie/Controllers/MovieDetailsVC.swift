//
//  MovieDetailsVC.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 01.05.2023.
//

import UIKit

class MovieDetailsVC: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    var mediaTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    

    func setupUI() {
        view.backgroundColor = Color.mainBG
        
        titleLabel.tintColor = .white
        titleLabel.textColor = .white
        titleLabel.text = mediaTitle
    }

}
