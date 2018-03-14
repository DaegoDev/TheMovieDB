//
//  HTTPMovie.swift
//  TheMovieDB
//
//  Created by Diego Alejandro Alvarez Gallego on 3/14/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import Foundation
import Alamofire

class HTTPMovie {
    static func nowPlaying(completionHandler: @escaping (MoviesResponse?)->Void) {
        do {
            let urlRequest = try MovieRouter.topRated.asURLRequest()
            Alamofire.request(urlRequest)
                .responseJSON { response in
                    guard response.result.isSuccess else {
                        print("\(#function) Movie query failed : \(String(describing: response.result.error))")
                        return
                    }
                    
                    guard let responseJSON = response.result.value as? [String : Any] else {
                        print("\(#function) Response jsonfy failed")
                        return
                    }
                    
                    let moviesResponse = MoviesResponse(responseJSON: responseJSON)
                    completionHandler(moviesResponse)
            }
        }
        catch {
            completionHandler(nil)
        }
    }
}
