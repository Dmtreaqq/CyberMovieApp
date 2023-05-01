//
//  Movie.swift
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

