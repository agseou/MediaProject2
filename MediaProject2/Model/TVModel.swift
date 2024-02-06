//
//  TV.swift
//  MediaProject2
//
//  Created by 은서우 on 2024/01/30.
//

import Foundation

struct TVModel: Decodable {
    //let page: Int
    let results: [TV]
//    let total_pages: Int
//    let total_results: Int
}

struct TV: Decodable {
    let backdrop: String?
    let id: Int
    let original_language: String
    let original_name: String
    let overview: String
    let popularity: Double
    let poster: String?
    let firstDate: String?
    let name: String
    let vote_average: Double
    let vote_count: Int
    
    enum CodingKeys: String, CodingKey {
        case backdrop = "backdrop_path"
        case id
        case original_language
        case original_name
        case overview
        case popularity
        case poster = "poster_path"
        case firstDate = "first_air_date"
        case name
        case vote_average
        case vote_count
    }
}
