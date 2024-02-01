//
//  TVDetail.swift
//  MediaProject2
//
//  Created by 은서우 on 2024/02/01.
//

import Foundation

// MARK: - TVDetailModel
struct TVDetailModel: Decodable {
    let backdropPath: String?
    let id: Int?
    let name: String?
    let numberOfSeasons: Int?
    let originalLanguage, originalName, overview: String?
    let posterPath: String?
    let seasons: [Season]?
    let status: String?
   
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case name
        case numberOfSeasons = "number_of_seasons"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case seasons
        case status
    }
}

// MARK: - Season
struct Season: Decodable {
    let airDate: String?
    let episodeCount, id: Int?
    let name, overview, posterPath: String?
    let seasonNumber: Int?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case voteAverage = "vote_average"
    }
}
