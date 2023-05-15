//
//  SearchMoviesView.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 15.05.2023.
//

import UIKit

class SearchMoviesView: UIView {
    @IBOutlet weak var searchMoviesTableView: UITableView!
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    @IBOutlet weak var searchSegmentedControl: UISegmentedControl!
    
    func setupUI() {        
        backgroundColor = Color.mainBG
        
        searchMoviesTableView.backgroundColor = Color.mainBG
        
        moviesSearchBar.barTintColor = Color.mainBG
        moviesSearchBar.searchTextField.textColor = .white
        
        searchSegmentedControl.selectedSegmentTintColor = Color.buttonBG
        searchSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        searchSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
}
