//
//  MovieDBRouter.swift
//  TheMovieDB
//
//  Created by Diego Alejandro Alvarez Gallego on 3/14/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import Foundation
import Alamofire

public enum MovieDBRouter {
    private static let basePath = "https://api.themoviedb.org/3"
    private static let apiKey = "1f4d7de5836b788bdfd897c3e0d0a24b"
    
    case movie
    case tvShow
    
    var path: String {
        switch self {
        case .movie:
            return "/movie/now_playing"
        case .tvShow:
            return "/tvshow/now_playing"
        }
    }
    
    public func nowPlayingURLRequest() throws -> URLRequest {
        let parameters: [String : Any] = {
            return ["api_key" : MovieDBRouter.apiKey]
        }()
        
        let url = try MovieDBRouter.basePath.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = HTTPMethod.get.rawValue
        print(request)
        return try URLEncoding.default.encode(request, with: parameters)
        
    }
}
