//
//  TrendAPIManager.swift
//  MediaProject2
//
//  Created by 은서우 on 2024/01/30.
//

import Foundation
import Alamofire

enum TVURL: String {
    static let baseURL = "https://api.themoviedb.org/3/"
    
    case trend = "trending/tv/week"
    case topLating = "tv/top_rated"
    case popular = "tv/popular"
    case korLang = "?language=ko-KR"
    
    func constructURL() -> String {
        print(TVURL.baseURL + self.rawValue + TVURL.korLang.rawValue)
        return TVURL.baseURL + self.rawValue + TVURL.korLang.rawValue
    }
}

struct TVAPIManager {
    
    static let shared = TVAPIManager()
    
    let header: HTTPHeaders = ["Authorization": APIKey.tmdbToken,
                               "accept": "application/json"]
    
    func fetchTrendingTV(completionHandler: @escaping ((TVModel) -> Void)) {
        let url = TVURL.trend.constructURL()
        print(url)
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: TVModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print("fail", failure)
            }
        }
    }
    
    func fetchTopRatingTV(completionHandler: @escaping ((TVModel) -> Void)) {
        let url = TVURL.topLating.constructURL()
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: TVModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print("fail", failure)
            }
        }
        
    }
    
    func fetchPopularTV(completionHandler: @escaping ((TVModel) -> Void)) {
        let url = TVURL.popular.constructURL()
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: TVModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print("fail", failure)
            }
        }
        
    }
}
