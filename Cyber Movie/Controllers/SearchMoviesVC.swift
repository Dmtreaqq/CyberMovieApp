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
    @IBOutlet weak var searchSegmentedControl: UISegmentedControl!
    
    var movies: [Movie] = []
    var timer: Timer?
    var searchChoice = ""
    
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
        let nib = UINib(nibName: "SearchMovieTableViewCell", bundle: nil)
        searchMoviesTableView.register(nib, forCellReuseIdentifier: "SearchMovieTableViewCell")
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            searchChoice = "movie"
        } else if sender.selectedSegmentIndex == 1 {
            searchChoice = "tv"
        }
    }
    
    func searchMovieBy(title: String) {
        NetworkService.instance.search(for: searchChoice, title) { moviesArr in
            self.movies = moviesArr
            self.searchMoviesTableView.reloadData()
        }
    }
}

extension SearchMoviesVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
            self.searchMovieBy(title: searchText)
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
        
        return cell
    }
}

