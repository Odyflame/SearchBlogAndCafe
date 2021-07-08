//
//  SearchView.swift
//  SearchingBlogAndCafe
//
//  Created by apple on 2021/07/06.
//

import UIKit
import RxSwift
import RxCocoa

protocol SearchViewDelegate: class {
    func didTapSearchButtonWithKeyword(text: String)
}

class SearchView: UISearchBar {

    enum Constant {
        static let paddingSpace = 12
    }
    var disposeBag = DisposeBag()
    weak var searchDelegate: SearchViewDelegate?
    
    lazy var searchButton = UIButton().then {
        $0.setTitle("Search", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAttribute()
        configureLayout()
        bindRx()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindRx() {
        self.searchButton.rx.tap
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: {
                
                print("하하")
                guard let txt = self.text else {
                    return
                }
                self.searchDelegate?.didTapSearchButtonWithKeyword(text: txt)
                
            })
            .disposed(by: disposeBag)
    }
    
    private func configureAttribute() {
        backgroundColor = .white
    }
    
    private func configureLayout() {
        addSubview(searchButton)
        
        //iOS13 이상부터는 searchTextField를 사용할 수 있으나 iOS11에서는 지원하지 않아 부득이하게 텍스트필드 안에 searchButton을 집어넣었습니다.
//        self.searchTextField.snp.makeConstraints {
//            $0.leading.equalToSuperview().offset(Constant.paddingSpace)
//            $0.trailing.equalTo(searchButton.snp.leading).offset(-Constant.paddingSpace)
//            $0.centerY.equalToSuperview()
//        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Constant.paddingSpace)
            $0.height.equalToSuperview().offset(-4)
        }
    }
    
    
}
