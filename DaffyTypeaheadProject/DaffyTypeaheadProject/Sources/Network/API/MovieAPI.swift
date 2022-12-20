//
//  MovieAPI.swift
//  DaffyTypeaheadProject
//

import Foundation

/// Protocol that designates properties relevant to API endpoints.
protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var url: URL? { get }
}

/// API details for the Movie Database.
class MovieAPI: Endpoint {
    static let apiKey = SecretsProvider().getAPIKey()
    
    var page: Int = 0

    var baseURL: String {
        "https://api.themoviedb.org/3"
    }

    var path: String {
        return "\(baseURL)/movie/top_rated?api_key=\(MovieAPI.apiKey)&language=en-US&page=\(page)&include_adult=false"
    }

    var url: URL? {
        URL(string: path)
    }
}
