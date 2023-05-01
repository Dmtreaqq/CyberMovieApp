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
    
    var mediaContent: [Media] = []
    var timer: Timer?
    var searchChoice = "movie"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchMoviesTableView.dataSource = self
        searchMoviesTableView.delegate = self
        moviesSearchBar.delegate = self

        setupUI()
        registerTableViewCell()
    }
    
    func setupUI() {
        view.backgroundColor = Color.mainBG
        
        searchMoviesTableView.backgroundColor = Color.mainBG
        
        moviesSearchBar.barTintColor = Color.mainBG
        moviesSearchBar.searchTextField.textColor = .white
        
        searchSegmentedControl.selectedSegmentTintColor = Color.buttonBG
        searchSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        searchSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
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
        
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.impactOccurred(intensity: 1)
    }
    
    func searchMovieBy(title: String) {
        NetworkService.instance.searchFor(model: ResponseMovie.self, searchChoice, title) { movieResponse in
            let moviesArr = movieResponse.results
            self.mediaContent = moviesArr.map({ Media(from: $0) })
            self.searchMoviesTableView.reloadData()
        }
    }
    
    func searchTvShowBy(title: String) {
        NetworkService.instance.searchFor(model: ResponseTV.self, searchChoice, title) { tvShowResponse in
            let tvShowsArr = tvShowResponse.results
            self.mediaContent = tvShowsArr.map({ Media(from: $0) })
            self.searchMoviesTableView.reloadData()
        }
    }
}

extension SearchMoviesVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
            
            if self.searchChoice == "movie" {
                self.searchMovieBy(title: searchText)
            } else if self.searchChoice == "tv" {
                self.searchTvShowBy(title: searchText)
            }
            
            searchBar.endEditing(true)
        }
    }
}

extension SearchMoviesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mediaContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMovieTableViewCell", for: indexPath) as?
                SearchMovieTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = mediaContent[indexPath.row]
        cell.configure(title: movie.name , release: String(movie.popularity) , poster: movie.posterPath, rating: String(movie.popularity), votes: String(movie.popularity))
        
        return cell
    }
}

extension SearchMoviesVC: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if moviesSearchBar.isFirstResponder {
            moviesSearchBar.resignFirstResponder()
        }
        
        if moviesSearchBar.searchTextField.isFirstResponder {
            moviesSearchBar.searchTextField.resignFirstResponder()
        }
    }
}

