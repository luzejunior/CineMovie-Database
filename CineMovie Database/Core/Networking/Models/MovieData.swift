//
//  MovieData.swift
//  CineMovie Database
//
//  Created by Luzenildo Junior on 25/10/18.
//  Copyright © 2018 Luzenildo Junior. All rights reserved.
//

struct MovieData: Decodable {
    var vote_count: Int
    var id: Int
    var video: Bool
    var vote_average: Float
    var title: String
    var popularity: Double
    var poster_path: String
    var original_language: String
    var original_title: String?
    var genre_ids: [Int]
    var backdrop_path: String
    var adult: Bool
    var overview: String
    var release_date: String
}
