//
//  SearchListTableView.swift
//  SearchingBlogAndCafe
//
//  Created by apple on 2021/07/07.
//

import UIKit
import RxSwift
import RxCocoa

class SearchListTableView: UITableView {

    let disposeBag = DisposeBag()
    lazy var filterHeaderView = FilterView()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configureAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAttribute() {
        self.backgroundColor = .white
        self.register(SearchListTableViewCell.self, forCellReuseIdentifier: SearchListTableViewCell.reuseIdentifier)
        self.tableHeaderView = filterHeaderView
    }
    
    func configure(viewModel: HomeViewModel) {
        
        viewModel.output.blog
            .bind(to: self.rx.items) { tableView, indexRow, data in
                let index = IndexPath(row: indexRow, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: SearchListTableViewCell.reuseIdentifier, for: index) as! SearchListTableViewCell
                cell.configure(data)
                return cell
            }.disposed(by: disposeBag)
        
        self.rx.itemSelected
            .map { $0.row }
            .subscribe(onNext: {
                
            })
            .disposed(by: disposeBag)
        
        self.rx.willDisplayCell
            .map { $0.indexPath.row }
            .subscribe(onNext: {
                
            })
            .disposed(by: disposeBag)
        
        self.rx.didScroll
            .subscribe(onNext: {
                
            })
            .disposed(by: disposeBag)
    }
}

//extension SearchListTableView: UITableViewDelegate {
//
//}
//
//extension SearchListTableView: UITableViewDataSource {
//
//}
