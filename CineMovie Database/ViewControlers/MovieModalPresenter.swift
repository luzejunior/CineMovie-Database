//
//  MovieModalPresenter.swift
//  CineMovie Database
//
//  Created by Luzenildo Junior on 25/10/18.
//  Copyright © 2018 Luzenildo Junior. All rights reserved.
//

import UIKit

class MovieModalPresenter {
    
    var movie: MovieData?
    
    var movieTitle: String {
        return movie?.title ?? ""
    }
    
    var movieGenre: String {
        var string = ""
        for id in movie?.genre_ids ?? [0] {
            string += "\(retrieveGenre(id)). "
        }
        return string
    }
    
    var movieReleaseDate: String {
        return movie?.release_date ?? ""
    }
    
    var moviePosterURL: URL {
        return URL(string: RequestUpcoming.imageDownloadURL + (movie?.poster_path ?? ""))!
    }
    
    var movieOverview: String {
        return movie?.overview ?? ""
    }
    
    init(movie: MovieData) {
        self.movie = movie
    }
}
