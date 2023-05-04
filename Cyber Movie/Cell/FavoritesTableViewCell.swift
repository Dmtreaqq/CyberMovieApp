//
//  FavoritesTableViewCell.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 04.05.2023.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    @IBOutlet weak var favoriteTitleLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    func configure(media: Media) {
        setupUI(media: media)
    }
    
    func setupUI(media: Media) {
        favoriteTitleLabel.text = media.name
        favoriteTitleLabel.textColor = .white
        
        self.backgroundColor = Color.mainBGtab
        self.selectionStyle = .none
        
        if media.posterPath != "" {
            let posterPathString = Config.API_MOVIE_IMG_HOST + media.posterPath
            let posterPath: URL? = URL(string: posterPathString)
            favoriteImageView.sd_setImage(with: posterPath)
        }
    }
}
