//
//  MovieResults.swift
//  DaffyTypeaheadProject
//

import Foundation

/// Object that stores properties of the movie results we get back from the API.
struct MovieResults: Codable {
    let page: Int
    let results: [Movie]
    let totalResults: Int
    let totalPages: Int
}
