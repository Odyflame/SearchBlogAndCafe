//
//  FilterView.swift
//  SearchingBlogAndCafe
//
//  Created by apple on 2021/07/07.
//

import UIKit
import RxSwift
import RxCocoa

class FilterView: UITableViewHeaderFooterView {

    enum Constant {
        static let FilterSize = 30
        static let SidePadding = 20
    }
    
    var disposeBag = DisposeBag()
    
    lazy var typeButton = UIButton().then {
        $0.contentHorizontalAlignment = .center
    }
    lazy var sortButton = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
    }
    lazy var bottomBorder = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureLayout()
        bindRx()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindRx() {
        
//        viewModel.updatedType
//            .map { $0.title }
//            .emit(to: typeButton.rx.title())
//            .disposed(by: disposeBag)
//
//        typeButton.rx.tap
//            .bind(to: viewModel.typeButtonTapped)
//            .disposed(by: disposeBag)
//
//        sortButton.rx.tap
//            .bind(to: viewModel.sortButtonTapped)
//            .disposed(by: disposeBag)
    }
    
    private func configureLayout() {
        [typeButton, sortButton, bottomBorder].forEach { addSubview($0) }
        
        typeButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(Constant.SidePadding)
        }
        
        sortButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(typeButton.snp.trailing).offset(Constant.SidePadding)
            $0.trailing.equalToSuperview().inset(Constant.SidePadding)
            $0.width.height.equalTo(Constant.FilterSize)
        }
        
        bottomBorder.snp.makeConstraints {
            $0.top.equalTo(typeButton.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
    
}
