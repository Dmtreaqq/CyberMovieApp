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
    
    var media: Media?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
//        loadTrailer()
    }
    
    private func loadTrailer() {

        guard let id = media?.id else { return }
        guard let mediaType = media?.mediaType else { return }

        NetworkService.instance.loadTrailers(for: id, type: mediaType) { [weak self] listOfKeys in
            guard let self else { return }
            guard let key = listOfKeys.first else { return }
            self.ytPlayer.load(withVideoId: key)
        }
    }
    
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        guard let media else { return }
        
        RealmManager.instance.addMedia(media)
        print("Added to favorites")
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        print("Like button pressed")
    }
    
    private func setupUI() {
        view.backgroundColor = Color.mainBG
        
        mediaImageView.layer.cornerRadius = 15
        
        releaseYearLabel.text = "Genres | \(media?.releaseDate ?? "")"
        releaseYearLabel.textColor = .white
        releaseYearLabel.textAlignment = .center
        
        titleLabel.textColor = .white
        titleLabel.text = media?.name
        
        addFavoriteButton.layer.cornerRadius = 15
        addFavoriteButton.clipsToBounds = true
        
        addLikeButton.layer.cornerRadius = 15
        addLikeButton.clipsToBounds = true
        
        scoreButton.layer.cornerRadius = 15
        scoreButton.clipsToBounds = true
        
        navigationItem.title = media?.name
        
        if let mediaImageString = media?.posterPath {
            let posterPathString = Config.API_MOVIE_IMG_HOST + mediaImageString
            let posterPath: URL? = URL(string: posterPathString)
            
            self.mediaImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.mediaImageView.sd_setImage(with: posterPath)
        }
    }
}
