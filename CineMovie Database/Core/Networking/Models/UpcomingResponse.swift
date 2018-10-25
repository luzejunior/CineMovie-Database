//
//  APIUpcomingResponse.swift
//  CineMovie Database
//
//  Created by Luzenildo Junior on 25/10/18.
//  Copyright © 2018 Luzenildo Junior. All rights reserved.
//

struct UpcomingResponse: Decodable {
    var results: [MovieData]
    var page: Int
    var total_results: Int
    var dates: Dates
    var total_pages: Int
}

struct Dates: Decodable {
    var maximum: String
    var minimum: String
}
