//
//  MovieDBRouter.swift
//  TheMovieDB
//
//  Created by Diego Alejandro Alvarez Gallego on 3/14/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import Foundation
import Alamofire

public enum MovieRouter: URLRequestConvertible {
    private static let basePath = "https://api.themoviedb.org/3/movie"
    private static let apiKey = "1f4d7de5836b788bdfd897c3e0d0a24b"
    public static var page = 1
    
    case nowPlaying
    case upcoming
    case popular
    case topRated
    
    var path: String {
        switch self {
        case .nowPlaying:
            return "/now_playing"
        case .upcoming:
            return "/upcoming"
        case .popular:
            return "/popular"
        case .topRated:
            return "/top_rated"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .nowPlaying, .upcoming, .popular, .topRated:
            return .get
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        
        let url = try MovieRouter.basePath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        var parameters: [String : Any] = ["api_key" : MovieRouter.apiKey]
        parameters["page"] = MovieRouter.page
       
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
