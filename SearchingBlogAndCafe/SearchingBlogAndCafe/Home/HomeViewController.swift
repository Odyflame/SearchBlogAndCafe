//
//  HomeViewController.swift
//  SearchingBlogAndCafe
//
//  Created by apple on 2021/07/05.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class HomeViewController: UIViewController {

    let disposeBag = DisposeBag()
    var viewModel = HomeViewModel()
    
    lazy var searchView = SearchView()
    lazy var searchListTableView = SearchListTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureAttribute()
        configureLayout()
    }
    
    private func bindRx() {
        viewModel.output.blog
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_) in
                
                print("blog data 변경")
                
            }).disposed(by: disposeBag)
    }
    
    private func configureAttribute() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func configureLayout() {
        [searchView, searchListTableView].forEach { view.addSubview($0) }
        
        searchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        searchListTableView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
