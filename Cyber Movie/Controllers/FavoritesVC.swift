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
        print("viewdidload")
        movies = RealmManager.instance.getMedia()

        view.backgroundColor = Color.mainBG
        setupUI()
        registerTableViewCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        movies = RealmManager.instance.getMedia()
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
            RealmManager.instance.deleteMediaAt(media.id)
            
            self.movies = RealmManager.instance.getMedia()
            self.favoritesTableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

