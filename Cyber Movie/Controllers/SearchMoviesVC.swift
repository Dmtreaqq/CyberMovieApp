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
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchMoviesTableView.dataSource = self
        searchMoviesTableView.delegate = self
        moviesSearchBar.delegate = self
        
        setupUI()
        registerTableViewCell()
        
        NetworkService.instance.setFirstPage()
        
        getTrendingMovies()
    }
    
    func setupUI() {
        moviesSearchBar.addSubview(activityIndicator)
        activityIndicator.frame = moviesSearchBar.bounds
        activityIndicator.color = Color.buttonBG
        
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
        let searchFieldText = moviesSearchBar.searchTextField.text ?? ""
        
        if sender.selectedSegmentIndex == 0 {
            searchChoice = "movie"
            NetworkService.instance.setFirstPage()
            
            if searchFieldText == "" {
                getTrendingMovies()
            } else {
                searchMovieBy(title: searchFieldText)
            }
            
        } else if sender.selectedSegmentIndex == 1 {
            searchChoice = "tv"
            NetworkService.instance.setFirstPage()
            
            if searchFieldText == "" {
                getTrendingTvShows()
            } else {
                searchTvShowBy(title: searchFieldText)
            }
        }
        
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.impactOccurred(intensity: 1)
    }
    
    func searchMovieBy(title: String) {
        NetworkService.instance.searchFor(model: ResponseMovie.self, searchChoice, title) { movieResponse in
            let moviesArr = movieResponse.results
            
            if NetworkService.instance.page == 1 {
                self.mediaContent = moviesArr.map({ Media(from: $0) })
            } else {
                self.mediaContent += moviesArr.map({ Media(from: $0) })
            }
            
            self.activityIndicator.removeFromSuperview()
            self.searchMoviesTableView.reloadData()
        }
    }
    
    func searchTvShowBy(title: String) {
        NetworkService.instance.searchFor(model: ResponseTV.self, searchChoice, title) { tvShowResponse in
            let tvShowsArr = tvShowResponse.results
            
            if NetworkService.instance.page == 1 {
                self.mediaContent = tvShowsArr.map({ Media(from: $0) })
            } else {
                self.mediaContent += tvShowsArr.map({ Media(from: $0) })
            }
            
            self.activityIndicator.removeFromSuperview()
            self.searchMoviesTableView.reloadData()
        }
    }
    
    func getTrendingMovies() {
        NetworkService.instance.getTrending(model: ResponseMovie.self, searchChoice) { movieResponse in
            let moviesArr = movieResponse.results
            
            if NetworkService.instance.page == 1 {
                self.mediaContent = moviesArr.map({ Media(from: $0) })
            } else {
                self.mediaContent += moviesArr.map({ Media(from: $0) })
            }
            
            self.searchMoviesTableView.reloadData()
        }
    }
    
    func getTrendingTvShows() {
        NetworkService.instance.getTrending(model: ResponseTV.self, searchChoice) { tvShowResponse in
            let tvShowsArr = tvShowResponse.results
            
            if NetworkService.instance.page == 1 {
                self.mediaContent = tvShowsArr.map({ Media(from: $0) })
            } else {
                self.mediaContent += tvShowsArr.map({ Media(from: $0) })
            }
            
            self.searchMoviesTableView.reloadData()
        }
    }
}

extension SearchMoviesVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        NetworkService.instance.setFirstPage()
        
        self.activityIndicator.removeFromSuperview()
        self.moviesSearchBar.addSubview(self.activityIndicator)
        activityIndicator.startAnimating()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { timer in
            
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
        cell.configure(title: movie.name , release: movie.releaseDate, poster: movie.posterPath, rating: String(movie.popularity), votes: String(movie.voteCount))
        
        return cell
    }
}

extension SearchMoviesVC: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Hide keyboard from searchbar when scrolling
        
        if moviesSearchBar.isFirstResponder {
            moviesSearchBar.resignFirstResponder()
        }
        
        if moviesSearchBar.searchTextField.isFirstResponder {
            moviesSearchBar.searchTextField.resignFirstResponder()
        }
        
        // Fetch next page when at bottom of tableView
        
        let offset = scrollView.contentOffset.y
        let height = scrollView.frame.size.height
        let contentHeight = scrollView.contentSize.height
        let distanceToBottom = contentHeight - offset - height
        
        var isLoadNeeded = true
        
        if distanceToBottom < 50 && isLoadNeeded {
            isLoadNeeded = false
            
            NetworkService.instance.goToNextPage()
            if searchChoice == "movie" {
                getTrendingMovies()
            } else if searchChoice == "tv" {
                getTrendingTvShows()
            }
            
            searchMoviesTableView.reloadData()
            
            isLoadNeeded = true
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "MovieDetails", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "MovieDetailsVC") as? MovieDetailsVC else {
            return
        }
        
        let media = mediaContent[indexPath.row]
        
        vc.mediaTitle = media.name
        vc.mediaImageString = media.backdropPath
        vc.releaseYear = media.releaseDate
        vc.votesCount = media.voteCount
        vc.mediaType = media.mediaType
        vc.id = media.id
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
