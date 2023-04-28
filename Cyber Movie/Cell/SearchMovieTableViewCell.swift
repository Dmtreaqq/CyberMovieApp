//
//  SearchMovieTableViewCell.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 28.04.2023.
//

import UIKit

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
    
    func configure(title: String, description: String) {
        movieTitleLabel.text = title
        movieDescriptionTextView.text = description
    }
}
