//
//  TrendAPIManager.swift
//  MediaProject2
//
//  Created by 은서우 on 2024/01/30.
//

import Foundation
import Alamofire

struct TVAPIManager {
    
    static let shared = TVAPIManager()
    
    func fetchTV(api: TMDBAPI, completionHandler: @escaping ((TVModel) -> Void)) {
        
        AF.request(api.endpoint, 
                   method: api.method,
                   parameters: api.parameter,
                   headers: api.header).responseDecodable(of: TVModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print("fail", failure)
            }
        }
    }
    
    func fetchDetailTV(api: TMDBAPI, completionHandler: @escaping ((TVDetailModel) -> Void)) {
        AF.request(api.endpoint, 
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: TVDetailModel.self) { response in
            switch response.result {
            case .success(let success):
                dump(success)
                completionHandler(success)
            case .failure(let failure):
                print("fail", failure)
            }
        }
    }
}
