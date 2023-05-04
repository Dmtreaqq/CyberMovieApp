//
//  FavoritesVC.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 28.04.2023.
//

import UIKit

class FavoritesVC: UIViewController {
    @IBOutlet weak var favoritesTableView: UITableView!
    
    
    let movies: [Media] = [Media(from: Movie(adult: false, backdropPath: "/gDvxT2z6TNxervG97WfpePRZ3aR.jpg", id: 1, title: "Some Movie", originalLanguage: "ru", originalTitle: "Some Movie", overview: "This is a some movie", posterPath: "/6iysgZr6Upm5RlAlVFo5f4D9euu.jpg", genreIDS: [1,2,3], popularity: 9.5, releaseDate: "2022-01-01", video: false, voteAverage: 8.4, voteCount: 1001))]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        
        view.backgroundColor = Color.mainBG
        
        favoritesTableView.backgroundColor = Color.mainBG
    }
}

extension FavoritesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(movies.count)
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        
        cell.textLabel?.text = movies[indexPath.row].name
        
        return cell
    }
    
    
}

extension FavoritesVC: UITableViewDelegate {
    
}
