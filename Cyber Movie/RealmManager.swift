//
//  RealmManager.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 04.05.2023.
//

import Foundation

class RealmManager {
    static let instance = RealmManager()
    
    private var movies: [Media] = []
    
    func getMovies() -> [Media] {
        movies
    }
    
    func addMovie(movie: Media) {
        movies.append(movie)
    }
    
    private init() {}
}
