//
//  MovieDetailsVC.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 01.05.2023.
//

import UIKit
import SDWebImage

class MovieDetailsVC: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var addFavoriteButton: UIButton!
    @IBOutlet weak var votesCountLabel: UILabel!
    @IBOutlet weak var addLikeButton: UIButton!
    @IBOutlet weak var favoriteTextLabel: UILabel!
    
    var mediaTitle: String?
    var mediaImageString: String?
    var releaseYear: String?
    var votesCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        print("Added to favorites")
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        print("Like button pressed")
    }
    
    func setupUI() {
        view.backgroundColor = Color.mainBG
        
        favoriteTextLabel.textColor = .white
        
        mediaImageView.layer.cornerRadius = 15
        
        votesCountLabel.text = String(votesCount ?? 0)
        votesCountLabel.textColor = .white
        
        releaseYearLabel.text = "Genres | \(releaseYear ?? "")"
        releaseYearLabel.textColor = .white
        releaseYearLabel.textAlignment = .center
        
        titleLabel.tintColor = .white
        titleLabel.textColor = .white
        titleLabel.text = mediaTitle
        
        addFavoriteButton.layer.cornerRadius = 15
        
        navigationItem.title = mediaTitle
        
        if let mediaImageString {
            let posterPathString = Config.API_MOVIE_IMG_HOST + mediaImageString
            let posterPath: URL? = URL(string: posterPathString)
            self.mediaImageView.sd_setImage(with: posterPath)
        }
    }
}
