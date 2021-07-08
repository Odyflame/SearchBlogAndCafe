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
    func getBlogData(search query: String, _ sort: String, _ page: Int)
    func getCafeData(search query: String, _ sort: String, _ page: Int)
    func getData(search query: String, _ sort: String, _ page: Int)
}

protocol HomeViewModelOutput {
    var blog: BehaviorRelay<[DocumentData]> { get }
    var cafe: BehaviorRelay<[DocumentData]> { get }
    var all: BehaviorRelay<[DocumentData]> { get }
    
    var type: PublishRelay<DataType> { get }
}

protocol HomeViewModelType {
    var input: HomeViewModelInput { get }
    var output: HomeViewModelOutput { get }
}

public class HomeViewModel: HomeViewModelType, HomeViewModelOutput, HomeViewModelInput {
    var blog: BehaviorRelay<[DocumentData]>
    var cafe: BehaviorRelay<[DocumentData]>
    var all: BehaviorRelay<[DocumentData]>
    
    var type: PublishRelay<DataType>
    
    var input: HomeViewModelInput { return self }
    
    var output: HomeViewModelOutput { return self }
    var page: Int = 1
    
    let disposeBag = DisposeBag()
    
    func getBlogData(search query: String, _ sort: String = "accuracy", _ page: Int = 1) {
        SearchController.shared.getBlogData(query: query, sort: sort, page: page)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] result in
                
                guard let self = self,
                      let element = result.element else {
                    return
                }
                
                let data = element.documents.map { DocumentData(docs: $0)}
                self.all.accept(data)
//                let temp = self.all.value + data
//                self.all.accept(temp)
            }.disposed(by: disposeBag)
    }
    
    func getCafeData(search query: String, _ sort: String = "accuracy", _ page: Int = 1) {
        SearchController.shared.getCafeData(query: query, sort: sort, page: page)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] result in
                
                guard let self = self,
                      let element = result.element else {
                    return
                }
                
                let data = element.documents.map { DocumentData(docs: $0)}
                self.all.accept(data)
//                let temp = self.all.value + data
//                self.all.accept(temp)
                
            }.disposed(by: disposeBag)
    }
    
    func getData(search query: String, _ sort: String, _ page: Int = 1) {
        getBlogData(search: query, sort, page)
        getCafeData(search: query, sort, page)
    }
    
    func initData() {
        self.all.accept([])
        self.blog.accept([])
        self.cafe.accept([])
    }
    
    func nextPage() -> Int {
        page += 1
        return page
    }
    
    func initPage() {
        page = 1
    }
    
    init() {
        blog = BehaviorRelay<[DocumentData]>(value: [])
        cafe = BehaviorRelay<[DocumentData]>(value: [])
        all = BehaviorRelay<[DocumentData]>(value: [])
        
        type = PublishRelay<DataType>()
    }
}
