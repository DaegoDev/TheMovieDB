//
//  MovieFacade.swift
//  TheMovieDB
//
//  Created by Diego Alejandro Alvarez Gallego on 3/14/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import Foundation
import Alamofire

class MovieFacade {
    static func getMovies(withCategory category: MovieRouter,completionHandler: @escaping (MoviesResponse?)->Void) {
        HTTPMovie.getMovies(withCategory: category) { moviesResponse in
            completionHandler(moviesResponse)
        }
    }    
}

