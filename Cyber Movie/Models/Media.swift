//
//  Media.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 01.05.2023.
//

import Foundation

struct Media: Codable {

    var id: Int
    var name: String
    var popularity: Double
    var posterPath: String
    var video: Bool

    init(from movie: Movie) {
        self.id = movie.id
        self.name = movie.originalTitle
        self.popularity = movie.popularity
        self.posterPath = movie.posterPath ?? ""
        self.video = movie.video
    }

    init(from tv: TvShow) {
        self.id = tv.id
        self.name = tv.originalName
        self.popularity = tv.popularity
        self.posterPath = tv.posterPath ?? ""
        self.video = false
    }
}

