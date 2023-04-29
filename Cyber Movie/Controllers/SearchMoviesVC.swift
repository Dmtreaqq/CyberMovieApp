//
//  SearchMoviesVC.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 28.04.2023.
//

import UIKit

class SearchMoviesVC: UIViewController {
    @IBOutlet weak var searchMoviesTableView: UITableView!
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchMoviesTableView.dataSource = self

        setupUI()
        registerTableViewCell()
        
        makeRequest()
    }
    
    func setupUI() {
        view.backgroundColor = Color.mainBG
    }
    
    func registerTableViewCell() {
        searchMoviesTableView.register(UINib(nibName: "SearchMovieTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchMovieTableViewCell")
    }
    
    func makeRequest() {
        NetworkService.instance.searchMovie(query: "Steins") { moviesArr in
//            print(moviesArr)
            self.movies = moviesArr
            
            self.searchMoviesTableView.reloadData()
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

