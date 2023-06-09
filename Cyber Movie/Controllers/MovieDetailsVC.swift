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
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var ytPlayer: YTPlayerView!
    
    var media: Media?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        loadTrailer()
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
        
        RealmService.instance.addRealmMedia(media)
        
        let alert = UIAlertController(title: media.name, message: "Media was added to favorites", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: media?.name, message: "Media was liked", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { action in
            print("Like button pressed")
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    private func buildGenresString() -> String {
        var result = ""
        
        guard let genres = media?.genreIDS else { return "" }
        
        for genreId in genres {
            if let genre = Genres[genreId] {
                result += genre + " | "
            } else {
                result += ""
            }
        }
        
        return result
    }
    
    private func setupUI() {
        view.backgroundColor = Color.mainBG
        
        mediaImageView.layer.cornerRadius = 15
        
        releaseYearLabel.text = convertDate(date: media?.releaseDate ?? "")
        releaseYearLabel.textColor = .white
        releaseYearLabel.textAlignment = .center
        
        titleLabel.textColor = .white
        titleLabel.text = media?.name
        
        genresLabel.textColor = .white
        genresLabel.text = buildGenresString()
        
        addFavoriteButton.layer.cornerRadius = 15
        addFavoriteButton.clipsToBounds = true
        
        addLikeButton.layer.cornerRadius = 15
        addLikeButton.clipsToBounds = true
        
        scoreButton.layer.cornerRadius = 15
        scoreButton.clipsToBounds = true
        
        navigationItem.title = media?.name
        
        if let mediaImageString = media?.backdropPath {
            let backdropPathString = Config.API_MOVIE_IMG_HOST + mediaImageString
            let backdropPath: URL? = URL(string: backdropPathString)
            
            self.mediaImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.mediaImageView.sd_setImage(with: backdropPath)
        }
    }
}
