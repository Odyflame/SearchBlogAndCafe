//
//  SearchView.swift
//  SearchingBlogAndCafe
//
//  Created by apple on 2021/07/06.
//

import UIKit
import RxSwift
import RxCocoa

class SearchView: UISearchBar {

    var disposeBag = DisposeBag()
    lazy var searchButton = UIButton().then {
        $0.setTitle("Search", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAttribute()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        self.searchButton.rx.tap
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: {
                print("하핳")
            })
            .disposed(by: disposeBag)
    }
    
    private func configureAttribute() {
        backgroundColor = .red
    }
    
    private func configureLayout() {
        addSubview(searchButton)
        
//        self.searchTextField.snp.makeConstraints {
//            $0.leading.equalToSuperview().offset(12)
//            $0.trailing.equalTo(searchButton.snp.leading).offset(-12)
//            $0.centerY.equalToSuperview()
//        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }
    
    
}
