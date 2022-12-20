//
//  MovieResultsTableViewCell.swift
//  DaffyTypeaheadProject
//

import UIKit

/// Custom cell class for the movie table view.
class MovieTableViewCell: UITableViewCell {
    var movie: Movie?
    
    func setupCell(movie: Movie) {
        textLabel?.text = movie.title
    }
}
