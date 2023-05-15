//
//  SearchMovieTableViewCell.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 28.04.2023.
//

import UIKit
import SDWebImage

class SearchMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieVotesRatingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func configure(media: Media) {
        movieTitleLabel.text = media.name
        releaseYearLabel.text = convertDate(date: media.releaseDate)
        movieRatingLabel.text = String(media.popularity)
        movieVotesRatingLabel.text = "Votes: \(media.voteCount)"
        
        let poster = media.posterPath
        let posterPathString = Config.API_MOVIE_IMG_HOST + poster
        let posterPath: URL? = URL(string: posterPathString)
        movieImageView.sd_setImage(with: posterPath)
        
    }
    
    func setupUI() {
        backgroundColor = Color.mainBG
        
        movieImageView.layer.cornerRadius = 15
        movieImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
        selectionStyle = .none
        
        movieTitleLabel.textColor = .white
        releaseYearLabel.textColor = .white
        movieRatingLabel.textColor = .white
        movieVotesRatingLabel.textColor = .white
    }
}
