//
//  TMDBAPI.swift
//  MediaProject2
//
//  Created by 은서우 on 2024/02/01.
//

import Foundation
import Alamofire

enum TMDBAPI {
    
    case trend
    case topLating
    case popular
    case seriesDetail(id: Int)
    case recommendation(id: Int)
    case credits(id: Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endpoint: URL {
        switch self {
        case .trend:
            return URL(string: baseURL + "trending/tv/week")!
        case .topLating:
            return URL(string: baseURL + "tv/top_rated")!
        case .popular:
            return URL(string: baseURL + "tv/popular")!
        case .seriesDetail(let id):
            return URL(string: baseURL + "tv/\(id)")!
        case .recommendation(let id):
            return URL(string: baseURL + "/tv/\(id)/recommendations")!
        case .credits(let id):
            return URL(string: baseURL + "tv/\(id)/credits")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIKey.tmdbToken]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .trend:
            ["language":"ko-KR"]
        case .topLating:
            ["language":"ko-KR"]
        case .popular:
            ["language":"ko-KR"]
        case .seriesDetail(let id):
            ["language":"ko-KR", "id": id]
        case .recommendation(let id):
            ["language":"ko-KR", "id": id]
        case .credits(let id):
            ["language":"ko-KR", "id": id]
        }
    }
    
}
