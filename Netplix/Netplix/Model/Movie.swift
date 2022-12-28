//
//  Movie.swift
//  Netplix
//
//  Created by erlina ng on 27/12/22.
//

import Foundation

struct AllMoviesResponse : Codable {
    let results : [Movie]
}

struct Movie : Codable {
    let id : Int
    let original_name : String?
    let original_title : String?
    let poster_path : String?
    let overview : String?
    let vote_average : Double
}
