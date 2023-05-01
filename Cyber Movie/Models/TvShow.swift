//
//  TvShow.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 01.05.2023.
//

struct TvShow: Codable {
    var adult: Bool
    var backdropPath: String?
    var genreIDS: [Int]
    var id: Int
    var originCountry: [String]
    var originalLanguage: String
    var originalName, overview: String
    var popularity: Double
    var posterPath: String?
    var firstAirDate, name: String
    var voteAverage: Double
    var voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case name
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
