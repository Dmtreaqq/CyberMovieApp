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
        let encodedQuery = encodeQueryParam(query) ?? ""
        
        let baseUrl: String = "\(Config.API_MOVIEDB_HOST)/3/search/\(searchType)"
        let urlParams: String = "?api_key=\(Config.TMDB_API_KEY)&query=\(encodedQuery)"
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
    
    func loadTrailers(for id: Int,
                      type: String,
                      completion: @escaping(([String])->())) {

        let baseUrl = "\(Config.API_MOVIEDB_HOST)/3/\(type)/\(id)/videos"
        let urlParams = "?api_key=\(Config.TMDB_API_KEY)&language=en-US"
        let url = baseUrl + urlParams

        AF.request(url).responseDecodable(of: VideoResponse.self) { dataResponce in
            let videos: [VideoResult] = dataResponce.value?.results ?? []
            let keys: [String] = videos.map { $0.key }
            completion(keys)
        }
    }
    
    private func encodeQueryParam(_ param: String) -> String? {
        return param.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
