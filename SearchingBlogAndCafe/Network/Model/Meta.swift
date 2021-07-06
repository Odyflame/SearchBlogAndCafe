//
//  Meta.swift
//  Network
//
//  Created by apple on 2021/07/05.
//

import Foundation

public struct Meta: Codable {
    var totalCount: Int?
    var pageableCount: Int?
    var isEnd: Bool?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case pageableCount = "pageable_count"
        case isEnd = "is_end"
    }
}
