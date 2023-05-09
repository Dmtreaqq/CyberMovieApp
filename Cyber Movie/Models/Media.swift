//
//  Media.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 01.05.2023.
//

import Foundation
import RealmSwift

struct Media: Codable {

    var id: Int
    var name: String
    var popularity: Double
    var posterPath: String
    var backdropPath: String
    var releaseDate: String
    var video: Bool
    var voteCount: Int
    var mediaType: String
    var genreIDS: [Int]

    init(from movie: Movie) {
        self.id = movie.id
        self.name = movie.originalTitle
        self.popularity = movie.popularity
        self.releaseDate = movie.releaseDate
        self.posterPath = movie.posterPath ?? ""
        self.backdropPath = movie.backdropPath ?? ""
        self.voteCount = movie.voteCount
        self.video = movie.video
        self.mediaType = MediaType.movie.rawValue
        self.genreIDS = movie.genreIDS
    }

    init(from tv: TvShow) {
        self.id = tv.id
        self.name = tv.originalName
        self.popularity = tv.popularity
        self.releaseDate = tv.firstAirDate
        self.posterPath = tv.posterPath ?? ""
        self.backdropPath = tv.backdropPath ?? ""
        self.voteCount = tv.voteCount
        self.video = false
        self.mediaType = MediaType.tv.rawValue
        self.genreIDS = tv.genreIDS
    }
    
    init(from realmMedia: RealmMedia) {
        self.id = realmMedia.id
        self.name = realmMedia.name
        self.popularity = realmMedia.popularity
        self.releaseDate = realmMedia.releaseDate
        self.posterPath = realmMedia.posterPath
        self.backdropPath = realmMedia.backdropPath
        self.voteCount = realmMedia.voteCount
        self.video = realmMedia.video
        self.mediaType = realmMedia.mediaType
        self.genreIDS = Array(realmMedia.genreIDS)
    }
}

