//
//  Movie.swift
//  TheMovieDB
//
//  Created by Diego Alejandro Alvarez Gallego on 3/13/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import Foundation

class Movie {
    var id: Int
    var title: String
    var voteAverage: Double
    var overview: String
    var posterPath: String?
    
    init(id: Int, title: String, voteAverage: Double, overview: String, posterPath: String = "") {
        self.id = id
        self.title = title
        self.voteAverage = voteAverage
        self.overview = overview
        self.posterPath = posterPath
    }
}

extension CustomStringConvertible {
    var description: String {
        var instanceDescription =  "\n**** \(type(of: self)) ****\n"
        let selfMirror = Mirror(reflecting: self)
        
        for child in selfMirror.children {
            if let propertyName = child.label {
                instanceDescription += "\(propertyName): \(child.value)\n"
            }
        }
        
        return instanceDescription
    }
}

extension Movie: CustomStringConvertible {}
