//
//  RealmMedia.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 04.05.2023.
//

import RealmSwift

class RealmMedia: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var popularity: Double
    @Persisted var posterPath: String
    @Persisted var backdropPath: String
    @Persisted var releaseDate: String
    @Persisted var video: Bool
    @Persisted var voteCount: Int
    @Persisted var mediaType: String
    @Persisted var genreIDS: List<Int>
}
