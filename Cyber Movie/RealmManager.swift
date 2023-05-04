//
//  RealmManager.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 04.05.2023.
//

import Foundation

class RealmManager {
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
    
    private init() {}
}
