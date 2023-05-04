//
//  MovieDetailsVC.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 01.05.2023.
//

import UIKit
import SDWebImage
import youtube_ios_player_helper

class MovieDetailsVC: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var addFavoriteButton: UIButton!
    @IBOutlet weak var addLikeButton: UIButton!
    @IBOutlet weak var scoreButton: UIButton!
    @IBOutlet weak var ytPlayer: YTPlayerView!
    
    var mediaTitle: String?
    var mediaImageString: String?
    var releaseYear: String?
    var votesCount: Int?
    var id: Int?
    var mediaType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        loadTrailer()
    }
    
    private func loadTrailer() {

        guard let id else { return }
        guard let mediaType else { return }

        NetworkService.instance.loadTrailers(for: id, type: mediaType) { [weak self] listOfKeys in
            guard let self else { return }
            guard let key = listOfKeys.first else { return }
            self.ytPlayer.load(withVideoId: key)
        }
    }
    
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        RealmManager.instance.addMovie(movie: Media(from: Movie(adult: false, backdropPath: "/gDvxT2z6TNxervG97WfpePRZ3aR.jpg", id: 1, title: "Scary Movie", originalLanguage: "rus", originalTitle: "Scary Movie", overview: "sasa", posterPath: "/6iysgZr6Upm5RlAlVFo5f4D9euu.jpg", genreIDS: [1], popularity: 2.2, releaseDate: "2022-2-2", video: false, voteAverage: 2121, voteCount: 2121)))
        print("Added to favorites")
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        print("Like button pressed")
    }
    
    private func setupUI() {
        view.backgroundColor = Color.mainBG
        
        mediaImageView.layer.cornerRadius = 15
        
        releaseYearLabel.text = "Genres | \(releaseYear ?? "")"
        releaseYearLabel.textColor = .white
        releaseYearLabel.textAlignment = .center
        
        titleLabel.textColor = .white
        titleLabel.text = mediaTitle
        
        addFavoriteButton.layer.cornerRadius = 15
        addFavoriteButton.clipsToBounds = true
        
        addLikeButton.layer.cornerRadius = 15
        addLikeButton.clipsToBounds = true
        
        scoreButton.layer.cornerRadius = 15
        scoreButton.clipsToBounds = true
        
        navigationItem.title = mediaTitle
        
        if let mediaImageString {
            let posterPathString = Config.API_MOVIE_IMG_HOST + mediaImageString
            let posterPath: URL? = URL(string: posterPathString)
            
            self.mediaImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.mediaImageView.sd_setImage(with: posterPath)
        }
    }
}
