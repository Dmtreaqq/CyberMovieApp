//
//  FavoritesTableViewCell.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 04.05.2023.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favoriteTitleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func configure(media: Media) {
        
        releaseYearLabel.text = convertDate(date: media.releaseDate)
        genresLabel.text = buildGenresString(genreIDS: media.genreIDS)
        favoriteTitleLabel.text = media.name
        
        if media.posterPath != "" {
            let posterPathString = Config.API_MOVIE_IMG_HOST + media.posterPath
            let posterPath: URL? = URL(string: posterPathString)
            favoriteImageView.sd_setImage(with: posterPath)
        }
    }
    
    func setupUI() {
        
        releaseYearLabel.textColor = .white
        genresLabel.textColor = .white
        favoriteTitleLabel.textColor = .white
        
        self.backgroundColor = Color.mainBGtab
        self.selectionStyle = .none
    }
    
    private func buildGenresString(genreIDS: [Int]) -> String {
        var result = ""
        
        for genreId in genreIDS {
            if let genre = Genres[genreId] {
                result += genre + " | "
            } else {
                result += ""
            }
        }
        
        return result
    }
}
