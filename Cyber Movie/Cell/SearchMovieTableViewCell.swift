//
//  SearchMovieTableViewCell.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 28.04.2023.
//

import UIKit
import SDWebImage

class SearchMovieTableViewCell: UITableViewCell {
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    //    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func configure(title: String, description: String, poster: String?) {
        movieTitleLabel.text = title
        movieDescriptionTextView.text = description
        
        if let poster {
            let posterPathString = Config.API_MOVIE_IMG_HOST + poster
            let posterPath: URL? = URL(string: posterPathString)
            movieImageView.sd_setImage(with: posterPath)
        }
    }
}
