//
//  TMDBSessionManager.swift
//  MediaProject2
//
//  Created by 은서우 on 2024/02/05.
//

import Foundation

enum errorType: Error {
    case invalidURL
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}

class TMDBSessionManager {
    
    static let shared = TMDBSessionManager()
    
    func request<T: Decodable>(type: T.Type, api: TMDBAPI, completionHandler: @escaping (T?, errorType?) -> Void) {
        
        var urlComponents = URLComponents(url: api.endpoint, resolvingAgainstBaseURL: true)
        
        if let queryParams = api.parameter as? [String: String] {
            var queryItems = [URLQueryItem]()
            for (key, value) in queryParams {
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
            urlComponents?.queryItems = queryItems
        }
        guard let url = urlComponents?.url else {
            completionHandler(nil, .invalidURL)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(APIKey.tmdbToken, forHTTPHeaderField: "Authorization")
        
        print(urlRequest)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                
                print("DATA: ", data)
                print("RESPONSE: ", response)
                print("ERROR: ", error)
                
                guard error == nil else {
                    print("네트워크 통신 실패")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                
                guard let data = data else {
                    print("통신은 성공했지만, 데이터가 안옴")
                    completionHandler(nil, .noData)
                    return
                }
                
                print(String(data: data, encoding: .utf8))
                
                guard let response = response as? HTTPURLResponse else {
                    print("통신은 성공했지만, 응답(ex. 상태코드)이 오지 않음")
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200  else {
                    print("통신은 성공했지만, 올바른 값이 오지 않은 상태!!!!")
                    completionHandler(nil, .invalidData)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    dump(result)
                    completionHandler(result, nil)
                } catch {
                    print(error)
                    completionHandler(nil, .invalidData)
                }
            }
        }.resume()
        
    }
}
