//
//  VideoResponse.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 02.05.2023.
//

import Foundation

// MARK: - Welcome
struct VideoResponse: Codable {
    var id: Int
    var results: [VideoResult]
}

// MARK: - Result
struct VideoResult: Codable {
    var iso639_1, iso3166_1, name, key: String
    var site: String
    var size: Int
    var type: String
    var official: Bool
    var publishedAt, id: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}

