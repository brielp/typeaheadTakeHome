//
//  MovieDetailViewController.swift
//  DaffyTypeaheadProject
//

import UIKit

/// View controller for the movie detail screen.
class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var leadingImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var userRating: UILabel!
    @IBOutlet weak var thumbsUpButton: UIButton!
    @IBOutlet weak var thumbsDownButton: UIButton!
    @IBOutlet weak var releaseDate: UILabel!
    
    var movie: Movie?
    
    // User interaction data not currently stored - idea for future expansion of the app
    @IBAction func thumbsUpPressed(_ sender: UIButton) {
        thumbsUpButton.tintColor = .systemGreen
        thumbsDownButton.tintColor = .systemGray
    }
    
    @IBAction func thumbsDownPressed(_ sender: UIButton) {
        thumbsDownButton.tintColor = .systemRed
        thumbsUpButton.tintColor = .systemGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movie = movie else {
            return
        }

        title = movie.title
        movieDescription.text = movie.overview
        titleLabel.text = movie.title
        userRating.text = "\(movie.voteAverage)/10"
     
        releaseDate.text = "Release Date: \(movie.releaseDate.prefix(4))"
        
        if let path = movie.backdropPath {
            loadImage(path: path)
        } else {
            leadingImage.image = UIImage(imageLiteralResourceName: "noImage")
        }
    }
    
    func loadImage(path: String) {
        let baseURL = "https://image.tmdb.org/t/p/w500"
        let url = URL(string: baseURL + path)
        if let url = url {
            leadingImage.load(url: url)
        }
    }
}

private extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
