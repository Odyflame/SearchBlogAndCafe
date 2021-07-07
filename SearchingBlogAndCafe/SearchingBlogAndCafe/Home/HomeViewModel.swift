//
//  HomeViewModel.swift
//  SearchingBlogAndCafe
//
//  Created by apple on 2021/07/06.
//

import Foundation
import Network
import RxSwift
import RxCocoa

protocol HomeViewModelInput {
    func getBlogData(search query: String, sort: String, page: Int)
    func getCafeData(search query: String, sort: String, page: Int)
    func getData(search query: String, sort: String, page: Int)
}

protocol HomeViewModelOutput {
    var blog: BehaviorRelay<[DocumentData]> { get }
    var cafe: BehaviorRelay<[DocumentData]> { get }
}

protocol HomeViewModelType {
    var input: HomeViewModelInput { get }
    var output: HomeViewModelOutput { get }
}

public class HomeViewModel: HomeViewModelType, HomeViewModelOutput, HomeViewModelInput {
    var blog: BehaviorRelay<[DocumentData]>
    
    var cafe: BehaviorRelay<[DocumentData]>
    
    var input: HomeViewModelInput { return self }
    
    var output: HomeViewModelOutput { return self }
    
    let disposeBag = DisposeBag()
    
    func getBlogData(search query: String, sort: String = "accuracy", page: Int) {
        SearchController.shared.getBlogData(query: query, sort: sort, page: page)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] result in
                
                guard let self = self,
                      let element = result.element else {
                    return
                }
                
                let data = element.documents.map { DocumentData(docs: $0)}
                self.blog.accept(data)
                
            }.disposed(by: disposeBag)
    }
    
    func getCafeData(search query: String, sort: String = "accuracy", page: Int) {
        SearchController.shared.getCafeData(query: query, sort: sort, page: page)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] result in
                
                guard let self = self,
                      let element = result.element else {
                    return
                }
                
                let data = element.documents.map { DocumentData(docs: $0)}
                self.cafe.accept(data)
                
            }.disposed(by: disposeBag)
    }
    
    func getData(search query: String, sort: String, page: Int) {
        
    }
    
    init() {
        blog = BehaviorRelay<[DocumentData]>(value: [])
        cafe = BehaviorRelay<[DocumentData]>(value: [])
    }
}
