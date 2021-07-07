//
//  SearchListTableViewCell.swift
//  SearchingBlogAndCafe
//
//  Created by apple on 2021/07/06.
//

import UIKit
import Kingfisher

class SearchListTableViewCell: UITableViewCell {

    static let reuseIdentifier = String(describing: SearchListTableViewCell.self)
    let thumbnailImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    let typeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .light)
        $0.sizeToFit()
    }
    
    let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.numberOfLines = 2
    }
    let datetimeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .light)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureAttribute()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureAttribute() {
        contentView.backgroundColor = .white
    }
    
    func configure(_ data: DocumentData) {
        thumbnailImageView.kf.setImage(with: data.thumbnailURL, placeholder: #imageLiteral(resourceName: "no-image"))
        typeLabel.text = data.type?.rawValue
        nameLabel.text = data.name
        titleLabel.text = data.title

        var datetime: String {
            let calendar = Calendar(identifier: .gregorian)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            let contentDate = data.datetime ?? Date()
            
            if calendar.isDateInToday(contentDate) {
                return "Today"
            } else if calendar.isDateInYesterday(contentDate) {
                return "Yesterday"
            } else {
                return dateFormatter.string(from: contentDate)
            }
        }

        datetimeLabel.text = datetime
    }

    private func configureLayout() {
        [thumbnailImageView, typeLabel, nameLabel, titleLabel, datetimeLabel].forEach {
            contentView.addSubview($0)
        }
        
        typeLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(8)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(typeLabel)
            $0.leading.equalTo(typeLabel.snp.trailing).offset(8)
            $0.trailing.lessThanOrEqualTo(thumbnailImageView.snp.leading).offset(-8)
        }
        
        thumbnailImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.trailing.bottom.equalToSuperview().inset(8)
            $0.width.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(8)
            $0.leading.equalTo(typeLabel)
            $0.trailing.equalTo(thumbnailImageView.snp.leading).offset(-8)
        }
        
        datetimeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(typeLabel)
            $0.trailing.equalTo(titleLabel)
            $0.bottom.equalTo(thumbnailImageView)
        }
    }
}
