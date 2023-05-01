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
    
    func searchFor<T: Codable>(model: T.Type, _ searchType: String, _ query: String,  completion: @escaping((T) -> ())) {
        let baseUrl: String = "\(Config.API_MOVIEDB_HOST)/3/search/\(searchType)"
        let urlParams: String = "?api_key=\(Config.TMDB_API_KEY)&query=\(query)"
        let url: String = baseUrl + urlParams
        
        AF.request(url).responseDecodable(of: T.self) { response in
            let moviesResponse = response.value
            completion(moviesResponse!)
        }
    }
    
    func getTrending<T: Codable>(model: T.Type, _ searchType: String, completion: @escaping((T) -> ())) {
        let baseUrl: String = "\(Config.API_MOVIEDB_HOST)/3/trending/\(searchType)/day"
        let urlParams: String = "?api_key=\(Config.TMDB_API_KEY)"
        let url: String = baseUrl + urlParams
        
        AF.request(url).responseDecodable(of: T.self) { response in
            let moviesResponse = response.value
            completion(moviesResponse!)
        }
    }
}
