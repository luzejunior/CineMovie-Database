//
//  File.swift
//  CineMovie Database
//
//  Created by Luzenildo Junior on 25/10/18.
//  Copyright © 2018 Luzenildo Junior. All rights reserved.
//

import UIKit

class RequestUpcoming {
    
    static private var url = "https://api.themoviedb.org/3/movie/upcoming"
    static private var apiKey = "1f54bd990f1cdfb230adb312546d765d"
    static var imageDownloadURL = "https://image.tmdb.org/t/p/w200/"
    
    static func PerformRequest(page: Int, completion: @escaping (UpcomingResponse) -> Void, error: ((NetworkError) -> Void)? = nil) {
        let requestURL = url + "?api_key=\(apiKey)&page=\(page)"
        
        getDataFromServer(path: requestURL, completion: { (data: UpcomingResponse) in
            completion(data)
        }) { (err: NetworkError) in
            guard let error = error else { return }
            error(err)
        }
    }
}

