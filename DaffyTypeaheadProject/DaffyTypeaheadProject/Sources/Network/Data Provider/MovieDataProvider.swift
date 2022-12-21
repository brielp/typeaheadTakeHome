//
//  MovieDataProvider.swift
//  DaffyTypeaheadProject
//

import Foundation

/// Movie data provider, responsible for setting up and kicking off requests to the API.
class MovieDataProvider {
   // TODO: `loadMovies` and `loadMovieDetails` methods
    let movieAPI = MovieAPI()
    
    func loadMovies(completion: @escaping ([Movie]?) -> Void) {
        var movies = [Movie]()
        let serialQueue = DispatchQueue(label: "appendMovieQueue")
        
        // Setting an arbitrary value for number of results in order to limit API calls in test app
        let lastResult = 50
        for page in 1...lastResult {
            getMoviePage(page: page) { result in
                switch result {
                case .failure(let error):
                    print("Error fetching movie data: ", error)
                case .success(let results):
                    if let results = results {
                        serialQueue.sync {
                            movies.append(contentsOf: results.results)
                        }
                    }
                    if page == lastResult {
                        completion(movies)
                    }
                }
            }
        }
    }
    
    func getMoviePage(page: Int, completion: @escaping (Result<MovieResults?, Error>) -> Void) {
        movieAPI.page = page
        guard let url = movieAPI.url else { return }
        let session = URLSession(configuration: .default)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let decodedData = try decoder.decode(MovieResults.self, from: data)
                    completion(.success(decodedData))
                } catch(let error) {
                    completion(.failure(error))
                }
                
            }
        }
        
        task.resume()
    }
}
