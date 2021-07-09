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
    
    enum Constant {
        static let searchButtonPaddingSpace = 12
    }
    
    lazy var searchView = UISearchBar().then {
        $0.backgroundColor = .white
    }
    lazy var searchButton = UIButton().then {
        $0.setTitle("Search", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
    }
    //lazy var searchListTableView = SearchListTableView()
    lazy var searchListTableView = UITableView().then {
        $0.backgroundColor = .white
        $0.register(SearchListTableViewCell.self, forCellReuseIdentifier: SearchListTableViewCell.reuseIdentifier)
        let filter = FilterView()
        $0.tableHeaderView = filter
        filter.filterDelegate = self
        $0.delegate = self
        $0.dataSource = self
    }
    
    var dataType: DataType = .blog
    var sortType: SortType = .accuracy
    
    var all = [DocumentData]()
    var cafe = [DocumentData]()
    var blog = [DocumentData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureAttribute()
        configureLayout()
        bindRx()
    }
    
    func setNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(changeSortTypeToTitle),
            name: Notification.Name.sortTypeChangedToTitle,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(changeSortTypeToDateTime),
            name: Notification.Name.sortTypeChangedToDateTime,
            object: nil)
    }
    
    @objc
    func changeSortTypeToTitle() {
        self.sortType = .accuracy
        self.viewModel.initData()
        self.viewModel.initPage()
        guard let txt = searchView.text else { return }
        self.viewModel.input.getData(search: txt, sortType.rawValue, 1, dataType: dataType)
    }
    
    @objc
    func changeSortTypeToDateTime() {
        self.sortType = .recency
        self.viewModel.initData()
        self.viewModel.initPage()
        guard let txt = searchView.text else { return }
        self.viewModel.input.getData(search: txt, sortType.rawValue, 1, dataType: dataType)
    }
    
    func bindRx() {
        viewModel.output.all
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.all = self?.viewModel.output.all.value ?? []
                
                self?.searchListTableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        searchButton.rx.tap
            .subscribe(onNext: {
                self.viewModel.initData()
                self.viewModel.initPage()
                
                guard let txt = self.searchView.text else { return }
                self.viewModel.input.getData(search: txt, self.sortType.rawValue, 1, dataType: self.dataType)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureAttribute() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    private func configureLayout() {
        [searchView, searchButton, searchListTableView].forEach { view.addSubview($0) }
        
        searchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalTo(searchView)
            $0.leading.equalTo(searchView.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().inset(Constant.searchButtonPaddingSpace)
            $0.height.equalTo(searchView).offset(-4)
        }
        
        searchListTableView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var vc = DetailViewController()
        vc.configure(all[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchListTableViewCell.reuseIdentifier) as? SearchListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(all[indexPath.row])
        
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        
        if distanceFromBottom <= height {
            //데이터를 받아와야함
        }
        
    }
}

extension HomeViewController: FilterViewDelegate {
    func didTapSortedButton() {
        showSortAlertView()
    }
    
    func didTapTypeButton() {
        
    }
}
