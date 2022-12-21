//
//  MovieResultsViewController.swift
//  DaffyTypeaheadProject
//

import UIKit

/// View controller for the movie results screen.
class MovieResultsViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let viewModel = MovieResultsViewModel()

    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        setUpView()
    }
    
    func setUpView() {
        title = "Top Rated Movies"
        
        view.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
        
        searchBar.searchBarStyle = .minimal
        
        viewModel.getMovieData { movies in
            if let movies = movies {
                DispatchQueue.main.async {
                    self.movies = movies
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
}

extension MovieResultsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell {
            cell.setupCell(movie: movies[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetail") as? MovieDetailViewController {
            vc.movie = movies[indexPath.row]

            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MovieResultsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.async {
            self.movies = self.viewModel.filterMovies(by: searchText)
            self.activityIndicator.stopAnimating()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
}
