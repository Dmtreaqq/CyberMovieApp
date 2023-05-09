//
//  SearchMoviesVC.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 28.04.2023.
//

import UIKit

enum MediaType: String  {
    case movie
    case tv
}

class SearchMoviesVC: UIViewController {
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    @IBOutlet weak var searchMoviesTableView: UITableView!
    @IBOutlet weak var searchSegmentedControl: UISegmentedControl!
    
    var mediaContent: [Media] = []
    var timer: Timer?
    var searchChoice = MediaType.movie
    
    let checkConnection = NetworkService.instance.checkInternetConnection
    
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
        let nibName = String(describing: SearchMovieTableViewCell.self)
        let nib = UINib(nibName: nibName, bundle: nil)
        searchMoviesTableView.register(nib, forCellReuseIdentifier: nibName)
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let searchFieldText = moviesSearchBar.searchTextField.text ?? ""
        
        if sender.selectedSegmentIndex == 0 {
            searchChoice = MediaType.movie
            NetworkService.instance.setFirstPage()
            
            if searchFieldText == "" {
                getTrendingMovies()
            } else {
                searchMovieBy(title: searchFieldText)
            }
            
        } else if sender.selectedSegmentIndex == 1 {
            searchChoice = MediaType.tv
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
        if !checkConnection() {
            return
        }
        
        NetworkService.instance.searchFor(model: ResponseMovie.self, searchChoice.rawValue, title) { movieResponse in
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
        if !checkConnection() {
            return
        }
        
        NetworkService.instance.searchFor(model: ResponseTV.self, searchChoice.rawValue, title) { tvShowResponse in
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
        if !checkConnection() {
            return
        }
        
        NetworkService.instance.getTrending(model: ResponseMovie.self, searchChoice.rawValue) { movieResponse in
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
        if !checkConnection() {
            return
        }
        
        NetworkService.instance.getTrending(model: ResponseTV.self, searchChoice.rawValue) { tvShowResponse in
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
        search(in: searchBar, for: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchBar.searchTextField.text ?? ""
        
        search(in: searchBar , for: searchText)
    }
    
    func search(in searchBar: UISearchBar, for searchText: String) {
        timer?.invalidate()
        NetworkService.instance.setFirstPage()
        
        self.activityIndicator.removeFromSuperview()
        self.moviesSearchBar.addSubview(self.activityIndicator)
        activityIndicator.startAnimating()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { timer in
            switch self.searchChoice {
            case .movie:
                if searchText.isEmpty {
                    self.getTrendingMovies()
                } else {
                    self.searchMovieBy(title: searchText)
                }
                
            case .tv:
                if searchText.isEmpty {
                    self.getTrendingTvShows()
                } else {
                    self.searchTvShowBy(title: searchText)
                }
                
            }
            
            self.activityIndicator.stopAnimating()
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
        // Extension for UITableView dequeueReusableCell
        
        let movie = mediaContent[indexPath.row]
        cell.configure(title: movie.name , release: movie.releaseDate, poster: movie.posterPath, rating: String(movie.popularity), votes: String(movie.voteCount))
        
        return cell
    }
}

extension SearchMoviesVC: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Hide keyboard from searchbar when scrolling
        
        moviesSearchBar.endEditing(true)
        
        // Fetch next page when at bottom of tableView
        
        let offset = scrollView.contentOffset.y
        let height = scrollView.frame.size.height
        let contentHeight = scrollView.contentSize.height
        let distanceToBottom = contentHeight - offset - height
        let distanseForLoadingNewPage: CGFloat = 50
        
        var isLoadNeeded = true
        
        if distanceToBottom < distanseForLoadingNewPage && isLoadNeeded {
            isLoadNeeded = false
            
            NetworkService.instance.goToNextPage()
            
            switch searchChoice {
                case .movie:
                    getTrendingMovies()
                case .tv:
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
        
        vc.media = media
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
