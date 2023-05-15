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
    private var searchMoviesView: SearchMoviesView! {
        guard isViewLoaded else { return nil }
        return (view as! SearchMoviesView)
    }
    
    var mediaContent: [Media] = [] {
        didSet {
            reloadTableData()
        }
    }
    
    var timer: Timer?
    var searchChoice = MediaType.movie
    let checkConnection = NetworkService.instance.checkInternetConnection
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        registerTableViewCell()
        
        NetworkService.instance.setFirstPage()
        
        getTrendingMovies()
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let searchFieldText = searchMoviesView.moviesSearchBar.searchTextField.text ?? ""
        
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
}

extension SearchMoviesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mediaContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchMovieTableViewCell = tableView.dequeue(cellForRowAt: indexPath)
        
        let movie = mediaContent[indexPath.row]
        cell.configure(media: movie)
        
        return cell
    }
}

extension SearchMoviesVC: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        endEditing()
        
        let goToNextPage = {
            NetworkService.instance.goToNextPage()
            
            switch self.searchChoice {
            case .movie:
                self.getTrendingMovies()
            case .tv:
                self.getTrendingTvShows()
            }
        }
        
        scrollView.performActionWhenScrollAtBottom(action: goToNextPage)
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

private extension SearchMoviesVC {
    func setupUI() {
        searchMoviesView.moviesSearchBar.addSubview(activityIndicator)
        activityIndicator.frame = searchMoviesView.moviesSearchBar.bounds
        activityIndicator.color = Color.buttonBG
        
        searchMoviesView.moviesSearchBar.delegate = self
        searchMoviesView.searchMoviesTableView.dataSource = self
        searchMoviesView.searchMoviesTableView.delegate = self
        
        searchMoviesView.setupUI()
    }
    
    func reloadTableData() {
        searchMoviesView.searchMoviesTableView.reloadData()
    }
    
    func endEditing() {
        searchMoviesView.moviesSearchBar.endEditing(true)
    }
    
    func registerTableViewCell() {
        let nibName = String(describing: SearchMovieTableViewCell.self)
        let nib = UINib(nibName: nibName, bundle: nil)
        searchMoviesView.searchMoviesTableView.register(nib, forCellReuseIdentifier: nibName)
    }
    
    func search(in searchBar: UISearchBar, for searchText: String) {
        timer?.invalidate()
        NetworkService.instance.setFirstPage()
        
        activityIndicator.removeFromSuperview()
        searchMoviesView.moviesSearchBar.addSubview(self.activityIndicator)
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

