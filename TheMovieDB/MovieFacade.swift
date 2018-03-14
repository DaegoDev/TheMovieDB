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
    static func nowPlaying(completionHandler: @escaping (MoviesResponse?)->Void) {
        HTTPMovie.nowPlaying { moviesResponse in
            completionHandler(moviesResponse)
        }
    }    
}

