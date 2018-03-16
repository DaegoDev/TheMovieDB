//
//  UIMovieList.swift
//  TheMovieDB
//
//  Created by Diego Alejandro Alvarez Gallego on 3/15/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import Foundation


protocol MovieList: class {
    var movieListDelegate: MovieListDelegate? { get set }
    
    func reloadAllData()
}
