//
//  RealmMedia.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 04.05.2023.
//

import RealmSwift

class RealmMedia: Object {
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var popularity: Double
    @Persisted var posterPath: String
    @Persisted var backdropPath: String
    @Persisted var releaseDate: String
    @Persisted var video: Bool
    @Persisted var voteCount: Int
    @Persisted var mediaType: String
    
//    init(media: Media) {
//        self.id = media.id
//        self.name = media.name
//        self.popularity = media.popularity
//        self.posterPath = media.posterPath
//        self.backdropPath = media.backdropPath
//        self.releaseDate = media.releaseDate
//        self.video = media.video
//        self.voteCount = media.voteCount
//        self.mediaType = media.mediaType
//    }
}
