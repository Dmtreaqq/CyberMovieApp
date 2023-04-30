//
//  SearchMoviesVC.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 28.04.2023.
//

import UIKit

class SearchMoviesVC: UIViewController {
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    @IBOutlet weak var searchMoviesTableView: UITableView!
    
    var movies: [Movie] = []
    
    var timer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchMoviesTableView.dataSource = self
        moviesSearchBar.delegate = self

        setupUI()
        registerTableViewCell()
    }
    
    func setupUI() {
        view.backgroundColor = Color.mainBG
    }
    
    func registerTableViewCell() {
        searchMoviesTableView.register(UINib(nibName: "SearchMovieTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchMovieTableViewCell")
    }
    
    func makeRequest(query: String) {
        NetworkService.instance.searchMovie(query: query) { moviesArr in
//            print(moviesArr)
            self.movies = moviesArr
            
            self.searchMoviesTableView.reloadData()
        }
    }
}

extension SearchMoviesVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
            self.makeRequest(query: searchText)
            
            searchBar.endEditing(true)
        }
    }
}

extension SearchMoviesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMovieTableViewCell", for: indexPath) as?
                SearchMovieTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = movies[indexPath.row]
        
        cell.configure(title: movie.title ?? "No title", description: movie.overview ?? "No overview", poster: movie.poster_path)
        
        //        let cell = UITableViewCell()
//
//        cell.textLabel?.text = "Test"
//        cell.selectionStyle = .none
        
        
        return cell
    }
}

