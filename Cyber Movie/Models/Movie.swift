//
//  Results.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 29.04.2023.
//

struct ResponseMovie: Codable {
    var page: Int
    var results: [Movie]
    var totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movie: Codable {
    var adult: Bool
    var backdropPath: String?
    var id: Int
    var title: String
    var originalLanguage: String
    var originalTitle, overview: String
    var posterPath: String?
    var genreIDS: [Int]
    var popularity: Double
    var releaseDate: String
    var video: Bool
    var voteAverage: Double
    var voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
