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
        movies = RealmService.instance.getRealmMedia()

        view.backgroundColor = Color.mainBG
        setupUI()
        registerTableViewCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        movies = RealmService.instance.getRealmMedia()
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
        let cell: FavoritesTableViewCell = favoritesTableView.dequeue(cellForRowAt: indexPath)
        
        cell.configure(media: movies[indexPath.row])
        
        return cell
    }
}

extension FavoritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            let media = self.movies[indexPath.row]
            
            RealmService.instance.removeMedia(media.id)
            self.movies.remove(at: indexPath.row)

            self.favoritesTableView.beginUpdates()
            self.favoritesTableView.deleteRows(at: [indexPath], with: .middle)
            self.favoritesTableView.endUpdates()
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

