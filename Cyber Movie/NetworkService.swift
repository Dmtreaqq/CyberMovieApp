//
//  NetworkService.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 29.04.2023.
//

import Foundation
import Alamofire

final class NetworkService {
    static let instance = NetworkService()
    private init() {}
    
    func searchMovie(_ query: String, completion: @escaping(([Movie]) -> ())) {
        let baseUrl: String = "\(Config.API_MOVIEDB_HOST)/3/search/movie"
        let urlParams: String = "?api_key=\(Config.TMDB_API_KEY)&query=\(query)"
        let url: String = baseUrl + urlParams
        
        AF.request(url).responseDecodable(of: ResponseMovie.self) { response in
            let moviesResponse = response.value?.results ?? []
            
            completion(moviesResponse)
        }
    }
}
