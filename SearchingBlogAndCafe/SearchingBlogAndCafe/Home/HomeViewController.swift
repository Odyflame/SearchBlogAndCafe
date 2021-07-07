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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureAttribute()
        configureLayout()
    }
    
    private func configureAttribute() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func configureLayout() {
        //[searchView, searchListView, historyListView, typeListView].forEach { view.addSubview($0) }
        view.addSubview(searchView)
        
        searchView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
}
