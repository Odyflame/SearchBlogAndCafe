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

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    var disposeBag = DisposeBag()
    lazy var searchButton = UIButton().then {
        $0.setTitle("Search", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: SearchViewBindable) {
        self.disposeBag = DisposeBag()
        
        self.rx.text
            .bind(to: viewModel.queryText)
            .disposed(by: disposeBag)
        
        Observable
            .merge(
                self.rx.searchButtonClicked.asObservable(),
                searchButton.rx.tap.asObservable()
            )
            .bind(to: viewModel.searchButtonTapped)
            .disposed(by: disposeBag)
        
        self.rx.textDidBeginEditing
            .bind(to: viewModel.textDidBeginEditing)
            .disposed(by: disposeBag)
        
        if #available(iOS 13.0, *) {
            viewModel.updateQueryText
                .emit(to: self.searchTextField.rx.text)
                .disposed(by: disposeBag)
        } else {
            // Fallback on earlier versions
        }
        
        viewModel.endEditing
            .emit(to: self.rx.endEditing)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        
    }
    
    private func layout() {
        addSubview(searchButton)
        
        if #available(iOS 13.0, *) {
            searchTextField.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(12)
                $0.trailing.equalTo(searchButton.snp.leading).offset(-12)
                $0.centerY.equalToSuperview()
            }
        } else {
            // Fallback on earlier versions
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}
