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
    func getBlogData(search query: String, page: Int)
    func getCafeData(search query: String, page: Int)
}

protocol HomeViewModelOutput {
    var blog: BehaviorRelay<[Document]> { get }
    var cafe: BehaviorRelay<[Document]> { get }
}

protocol HomeViewModelType {
    var input: HomeViewModelInput { get }
    var output: HomeViewModelOutput { get }
}

public class HomeViewModel: HomeViewModelType, HomeViewModelOutput, HomeViewModelInput {
    var blog: BehaviorRelay<[Document]>
    
    var cafe: BehaviorRelay<[Document]>
    
    var input: HomeViewModelInput { return self }
    
    var output: HomeViewModelOutput { return self }
    
    let disposeBag = DisposeBag()
    
    func getBlogData(search query: String, page: Int) {
        SearchController.shared.getBlogaData(query: query, page: page)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] result in
                
                guard let self = self,
                      let element = result.element else {
                    return
                }
                
                
                
                self.blog.accept(element.documents)
                
            }.disposed(by: disposeBag)
    }
    
    func getCafeData(search query: String, page: Int) {
        
    }
    
    init() {
        blog = BehaviorRelay<[Document]>(value: [])
        cafe = BehaviorRelay<[Document]>(value: [])
    }
}
