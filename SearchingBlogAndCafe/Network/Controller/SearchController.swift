//
//  SearchController.swift
//  Network
//
//  Created by apple on 2021/07/05.
//

import Foundation
import Moya
import RxSwift

public class SearchController {
    public static let shared = SearchController()
    private let serviceManager = SearchServiceManager()
    
    public func getBlogaData(query: String, page: Int) -> Observable<Blog>{
        serviceManager.provider.rx
            .request(SearchService.getBlogData(query: query, page: page))
            .map(Blog.self)
            .asObservable()
    }
    
    public func getCafeData(query: String, page: Int) -> Observable<Cafe> {
        serviceManager.provider.rx
            .request(SearchService.getCafeData(query: query, page: page))
            .map(Cafe.self)
            .asObservable()
    }
}
