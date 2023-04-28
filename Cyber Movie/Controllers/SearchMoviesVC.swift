//
//  SearchMoviesVC.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 28.04.2023.
//

import UIKit

class SearchMoviesVC: UIViewController {
    @IBOutlet weak var searchMoviesTableView: UITableView!
    
    let arr = ["Movie 1", "Some Movie", "Another Movie"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchMoviesTableView.dataSource = self

        setupUI()
        registerTableViewCell()
    }
    
    func setupUI() {
        view.backgroundColor = Color.mainBG
    }
    
    func registerTableViewCell() {
        searchMoviesTableView.register(UINib(nibName: "SearchMovieTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchMovieTableViewCell")
    }
}

extension SearchMoviesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMovieTableViewCell", for: indexPath) as?
                SearchMovieTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(title: arr[indexPath.row], description: arr[indexPath.row])
        
        //        let cell = UITableViewCell()
//
//        cell.textLabel?.text = "Test"
//        cell.selectionStyle = .none
        
        
        return cell
    }
}

