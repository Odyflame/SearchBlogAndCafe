//
//  DetailViewController.swift
//  SearchingBlogAndCafe
//
//  Created by apple on 2021/07/06.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {

    lazy var contentView = UIStackView().then {
        $0.alignment = .fill
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 12
    }
    
    lazy var thumbnailImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 28, weight: .bold)
    }
    
    lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.numberOfLines = 2
    }
    
    lazy var contentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 0
    }
    
    lazy var datetimeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .light)
    }
    
    lazy var urlLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .light)
    }
    
    lazy var urlButton = UIButton().then {
        $0.setTitle("이동", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
    }
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAttribute()
        configureLayout()
        bindRx()
    }
    
    private func configureAttribute() {
        view.backgroundColor = .white
    }
    
    private func bindRx() {
        self.urlButton.rx.tap
            .asDriver()
            .drive(onNext: { view in
                
                var detailWebViewcontroller = DetailWebViewController()
                
                print("\(self.urlLabel.text)")
                detailWebViewcontroller.configureWebview(url: URL(string: self.urlLabel.text ?? "")!, title: self.titleLabel.text ?? "")
                
                self.navigationController?.pushViewController(detailWebViewcontroller, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func configure(_ data: DocumentData) {
        let thumbnailURL = data.thumbnailURL
        thumbnailImageView.kf.setImage(with: thumbnailURL, placeholder: #imageLiteral(resourceName: "no-image"))
        contentLabel.text = data.contents
        nameLabel.text = data.name
        titleLabel.text = data.title
        urlLabel.text = data.url?.absoluteString

        datetimeLabel.text = String.convertToDate(data.datetime)
        
        print("화하핳 \(data.type?.rawValue)")
        title = data.type?.rawValue
    }
    
    private func configureLayout() {
        let urlView = UIView()
        [urlLabel, urlButton].forEach { urlView.addSubview($0) }
        
        [thumbnailImageView, nameLabel, titleLabel, contentLabel, datetimeLabel, urlView].forEach {
            contentView.addArrangedSubview($0)
        }
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.center.equalToSuperview()
        }
        
        thumbnailImageView.snp.makeConstraints {
            $0.width.height.equalTo(240)
        }
        
        urlLabel.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
        }
        
        urlButton.snp.makeConstraints {
            $0.centerY.equalTo(urlLabel)
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(urlLabel.snp.trailing).offset(8)
        }
    }
}
