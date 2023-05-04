//
//  FavoritesVC.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 28.04.2023.
//

import UIKit

class FavoritesVC: UIViewController {
    @IBOutlet weak var favoritesTableView: UITableView!
    
    
    var movies: [Media] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        movies = RealmManager.instance.getMedia()
        movies = RealmManager.instance.getRealmMedia()

        view.backgroundColor = Color.mainBG
        setupUI()
        registerTableViewCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        movies = RealmManager.instance.getMedia()
        movies = RealmManager.instance.getRealmMedia()
        favoritesTableView.reloadData()
    }
    
    
    func setupUI() {
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        favoritesTableView.backgroundColor = Color.mainBG

        view.backgroundColor = Color.mainBG

    }
    
    func registerTableViewCell() {
        let nib = UINib(nibName: "FavoritesTableViewCell", bundle: nil)
        favoritesTableView.register(nib, forCellReuseIdentifier: "FavoritesTableViewCell")
    }
}

extension FavoritesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell") as? FavoritesTableViewCell else {
            print("error")
            return UITableViewCell()
        }
        
        cell.configure(media: movies[indexPath.row])
        
        return cell
    }
}

extension FavoritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            let media = self.movies[indexPath.row]
//            RealmManager.instance.deleteMediaAt(media.id)
            RealmManager.instance.removeMedia(media.id)
            
//            self.movies = RealmManager.instance.getMedia()
            self.movies = RealmManager.instance.getRealmMedia()
            self.favoritesTableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "MovieDetails", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "MovieDetailsVC") as? MovieDetailsVC else {
            return
        }
        
        let media = movies[indexPath.row]
        
        vc.media = media
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

