//
//  MovieResponse.swift
//  TheMovieDB
//
//  Created by Diego Alejandro Alvarez Gallego on 3/13/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import Foundation

class MoviesResponse {
    var movies: [Movie]?
    var totalPages: Int?
    var page: Int?
    
    init?(responseJSON: [String : Any]) {
        guard let totalPages = responseJSON["total_pages"] as? Int,
            let page = responseJSON["page"] as? Int,
            let moviesJSON = responseJSON["results"] as? [[String : Any]] else {
                return
        }
        
        self.totalPages = totalPages
        self.page = page
        
        self.movies = moviesJSON.map { movie -> Movie in
            let id = movie["id"] as! Int
            let title = movie["title"] as! String
            let voteAverage = movie["vote_average"] as! Double
            let overview = movie["overview"] as! String
            
            let movieObject = Movie(id: id, title: title, voteAverage: voteAverage, overview: overview)
            
            if let posterPath = movie["poster_path"] as? String {
                movieObject.posterPath = posterPath
            }
            
            return movieObject
        }
    }
}

extension MoviesResponse:CustomStringConvertible {}
