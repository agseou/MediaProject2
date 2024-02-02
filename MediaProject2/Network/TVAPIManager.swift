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
    
    func request<T: Decodable>(type: T.Type, api: TMDBAPI, completionHandler: @escaping ((T) -> Void)) {
        
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print("fail", failure)
            }
        }
    }
}
