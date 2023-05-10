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
    
    func configure(title: String, release: String, poster: String?, rating: String, votes: String) {
        
        movieTitleLabel.text = title
        releaseYearLabel.text = convertDate(date: release)
        movieRatingLabel.text = rating
        movieVotesRatingLabel.text = "Votes: \(votes)"
        
        if let poster {
            let posterPathString = Config.API_MOVIE_IMG_HOST + poster
            let posterPath: URL? = URL(string: posterPathString)
            movieImageView.sd_setImage(with: posterPath)
        }
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
