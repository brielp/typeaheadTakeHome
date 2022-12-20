import Foundation

struct Movie: Codable {
    let posterPath: String?
    let title: String
    let backdropPath: String?
    let id: Int
    let overview: String
    let releaseDate: String
    let popularity: Double
    let voteCount: Int
    let voteAverage: Double
}
