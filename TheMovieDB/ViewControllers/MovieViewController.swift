//
//  MovieViewController.swift
//  TheMovieDB
//
//  Created by Diego Alejandro Alvarez Gallego on 3/16/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController, MovieListDelegate {
    
    var moviesResponse: MoviesResponse?
    var moviesImageUrl: [URL]?
    var movieListView: MovieList?
    
    // MARK: - IBOUTLETS
    
    @IBOutlet weak var mainContentView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadMoviesWith(category: .popular)
    }
    
    // MARK: - MovieListDelegate
    
    func numberOfCells() -> Int {
        return moviesResponse?.movies?.count ?? 0
    }
    
    func configureCell(cell: MovieListCell, index: Int) {
    }

    // MARK: - CLASS HELPERS
    
    private func configureCollectionView() {
        let collectionFrame = CGRect(x: 0, y: 0, width: mainContentView.frame.width, height: mainContentView.frame.height)
        movieListView = MovieListCollectionView(frame: collectionFrame)
        movieListView?.movieListDelegate = self
        
        guard let tempMovieListView = movieListView as? UIView else {
            movieListView = nil
            return
        }
        mainContentView.addSubview(tempMovieListView)
        constrintMovieList(to: mainContentView)
    }
    
    private func configureTableView() {
        
        let tableFrame = CGRect(x: 0, y: 0, width: mainContentView.frame.width, height: mainContentView.frame.height)
        movieListView = MovieListTableView(frame: tableFrame)
        movieListView?.movieListDelegate = self
        
        guard let tempMovieListView = movieListView as? UIView else {
            movieListView = nil
            return
        }
        mainContentView.addSubview(tempMovieListView)
        constrintMovieList(to: mainContentView)
    }
    
    private func constrintMovieList(to: UIView) {
        
        guard let tempMovieListView = movieListView as? UIView else {
            movieListView = nil
            return
        }
        
        tempMovieListView.translatesAutoresizingMaskIntoConstraints = false
        tempMovieListView.topAnchor.constraint(equalTo: to.topAnchor, constant: 0).isActive = true
        tempMovieListView.bottomAnchor.constraint(equalTo: to.bottomAnchor, constant: 0).isActive = true
        tempMovieListView.leftAnchor.constraint(equalTo: to.leftAnchor, constant: 0).isActive = true
        tempMovieListView.rightAnchor.constraint(equalTo: to.rightAnchor, constant: 0).isActive = true
    }
    
    private func loadMoviesWith(category: MovieRouter) {
        MovieFacade.getMovies(withCategory: category) { moviesResponse in
            self.moviesResponse = moviesResponse
            self.movieListView?.reloadAllData()
        }
    }
    
    private func buildMoviesImageUrl() {
        guard let movies = moviesResponse?.movies else { return }
        for movie in movies {
            let url = try? "https://image.tmdb.org/t/p/w154\(movie.posterPath ?? "")".asURL()
        }
    }
    
    // MARK: - IBACTIONS
    
    @IBAction func changeCategory(_ sender: UISegmentedControl) {
    }
    
}
