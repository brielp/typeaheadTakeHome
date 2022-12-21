//
//  DaffyTypeaheadProjectTests.swift
//  DaffyTypeaheadProjectTests
//
//  Created by Brielle Petrie on 12/20/22.
//

import XCTest
@testable import DaffyTypeaheadProject

final class MovieResultsViewModelTests: XCTestCase {

    func testFilterMovies() throws {
        let sut = MovieResultsViewModel()
        var testMovies = [Movie]()
        let movie1 = Movie(posterPath: nil, title: "Movie", backdropPath: nil, id: 1, overview: "", releaseDate: "", popularity: 0, voteCount: 0, voteAverage: 0)
        let movie2 = Movie(posterPath: nil, title: "Another", backdropPath: nil, id: 2, overview: "", releaseDate: "", popularity: 0, voteCount: 0, voteAverage: 0)
        let movie3 = Movie(posterPath: nil, title: "Third", backdropPath: "", id: 3, overview: "", releaseDate: "", popularity: 0, voteCount: 0, voteAverage: 0)
        testMovies.append(contentsOf: [movie1, movie2, movie3])
        
        sut.movies = testMovies
        let resultMoviesEmptyString = sut.filterMovies(by: "")
        XCTAssertEqual(testMovies, resultMoviesEmptyString)
        
        let resultMovies = sut.filterMovies(by: "M")
        XCTAssertEqual([movie1], resultMovies)
    }

}

extension Movie: Equatable {
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.title == rhs.title && lhs.id == rhs.id
    }
}
