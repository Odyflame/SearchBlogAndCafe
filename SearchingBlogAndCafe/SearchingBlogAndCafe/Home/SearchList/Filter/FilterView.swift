//
//  FilterView.swift
//  SearchingBlogAndCafe
//
//  Created by apple on 2021/07/07.
//

import UIKit
import RxSwift
import RxCocoa

protocol FilterViewDelegate: class {
    func didTapSortedButton()
    func didTapTypeButton()
}

class FilterView: UITableViewHeaderFooterView {

    enum Constant {
        static let FilterSize = 30
        static let SidePadding = 20
    }
    
    var disposeBag = DisposeBag()
    
    var dataType: DataType = .all
    var sortType: SortType = .accuracy
    
    weak var filterDelegate: FilterViewDelegate?
        
    lazy var typeButton = UIButton().then {
        $0.setTitle(DataType.all.rawValue, for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.backgroundColor = .white
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
        
        self.typeButton.rx.tap
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                self.filterDelegate?.didTapTypeButton()
            })
            .disposed(by: disposeBag)

        self.sortButton.rx.tap
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                
                self.filterDelegate?.didTapSortedButton()
                
            })
            .disposed(by: disposeBag)
    }
    
    private func configureLayout() {
        [typeButton, sortButton].forEach { addSubview($0) }
        
        typeButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(Constant.SidePadding)
            $0.height.equalTo(Constant.FilterSize)
        }
        
        sortButton.snp.makeConstraints {
            $0.centerY.equalTo(typeButton)
            $0.leading.equalTo(typeButton.snp.trailing).offset(Constant.SidePadding)
            $0.trailing.equalToSuperview().inset(Constant.SidePadding)
            $0.width.height.equalTo(Constant.FilterSize)
        }
    }
    
}
