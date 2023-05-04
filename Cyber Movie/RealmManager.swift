//
//  RealmManager.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 04.05.2023.
//

import Foundation
import RealmSwift

class RealmManager {
    private let realm = try! Realm()
    
    static let instance = RealmManager()
    
    private var mediaArray: [Media] = []
    
    func getMedia() -> [Media] {
        mediaArray
    }
    
    func addMedia(_ media: Media) {
        mediaArray.append(media)
    }
    
    func deleteMediaAt(_ mediaId: Int) {
        let removeIndex = mediaArray.firstIndex { media in
            media.id == mediaId
        }
        
        mediaArray.remove(at: removeIndex!)
    }
    
    func getRealmMedia() -> [Media] {
        let realmResults = Array(realm.objects(RealmMedia.self))
        
        let mediaArray = realmResults.map { item in
            convertRealmToMedia(realmMedia: item)
        }
        
        return mediaArray
    }
    
    func addRealmMedia(_ media: Media) {
        let realmMedia = convertMediaToRealm(media: media)
        
        try! realm.write {
            realm.add(realmMedia)
        }
    }
    
    func removeMedia(_ mediaId: Int) {
        try! realm.write {
            let movies = realm.objects(RealmMedia.self)
            
            let movie = movies.where {
                $0.id == mediaId
            }
            
            realm.delete(movie)
        }
    }
    
    func convertMediaToRealm(media: Media) -> RealmMedia {
        let realmMedia = RealmMedia()
        
        realmMedia.name = media.name
        realmMedia.backdropPath = media.backdropPath
        realmMedia.posterPath = media.posterPath
        realmMedia.releaseDate = media.releaseDate
        realmMedia.mediaType = media.mediaType
        realmMedia.popularity = media.popularity
        realmMedia.voteCount = media.voteCount
        realmMedia.video = media.video
        realmMedia.id = media.id
        
        return realmMedia
    }
    
    func convertRealmToMedia(realmMedia: RealmMedia) -> Media {
        return Media(from: realmMedia)
    }
 
    private init() {}
}
