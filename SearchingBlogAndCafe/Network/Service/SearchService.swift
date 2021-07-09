//
//  BlogService.swift
//  Network
//
//  Created by apple on 2021/07/05.
//

import Foundation

import Foundation
import Moya
import Alamofire

enum SearchService {
    case getBlogData(query: String, sort: String, page: Int = 1)
    case getCafeData(query: String, sort: String, page: Int = 1)
}

extension SearchService: TargetType {
    var baseURL: URL {
        URL(string: BaseURL.base.rawValue)!
    }
    
    var path: String {
        switch self {
        case .getBlogData: return "v2/search/blog"
        case .getCafeData: return "v2/search/cafe"
        }
        
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .getBlogData(let query, let sort, let page):
            return .requestParameters(parameters: ["query": query,
                                                   "sort": sort,
                                                   "page" : page,
                                                   "size": 25], encoding: URLEncoding.default)
        case .getCafeData(let query, let sort, let page):
            return .requestParameters(parameters: ["query": query,
                                                   "sort": sort,
                                                   "page" : page,
                                                   "size": 25], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Authorization": "KakaoAK \(KakaoAPIKey.key.rawValue)"
          ]
    }
    
}

class SearchServiceManager: BaseManager<SearchService> { }
