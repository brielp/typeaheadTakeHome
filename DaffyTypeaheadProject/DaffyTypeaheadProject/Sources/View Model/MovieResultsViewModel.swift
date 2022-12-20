//
//  MovieResultsViewModel.swift
//  DaffyTypeaheadProject
//

import Foundation

/// View model for the movie results screen.
class MovieResultsViewModel: ObservableObject {
    private let movieDataProvider: MovieDataProvider
    var movies = [Movie]()

    init() {
        self.movieDataProvider = MovieDataProvider()
    }
    
    func getMovieData(completion: @escaping ([Movie]?) -> Void) {
        movieDataProvider.loadMovies { result in
            if let result = result {
                self.movies = result
                completion(result)
            }
        }
    }
    
    func filterMovies(by inputString: String) -> [Movie] {
        if inputString.isEmpty {
            return movies
        }
        return movies.filter { movie in
            movie.title.lowercased().contains(inputString.lowercased())
        }
    }
}
