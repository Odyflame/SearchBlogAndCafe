//
//  String+.swift
//  SearchingBlogAndCafe
//
//  Created by apple on 2021/07/09.
//

import Foundation

extension String {
    
    static func parse<T: CodingKey>(_ values: KeyedDecodingContainer<T>, key: T) -> String? {
        guard let rawValue = try? values.decode(String.self, forKey: key) else { return nil }
        
        return rawValue
            .replacingOccurrences(of: "<[^>]+>&;", with: "", options: .regularExpression, range: nil)
    }
    
    static func parse(value: String?) -> String? {
        
        guard let value = value else { return nil }
        
        return value
            .replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            .replacingOccurrences(of: "&[^;]+;", with: "", options: .regularExpression, range: nil)
    }
    
    static func convertToDate(_ value: Date?) -> String? {
        guard let value = value else { return nil }
        
        let calender = Calendar(identifier: .gregorian)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        if calender.isDateInToday(value) {
            return "Today"
        } else if calender.isDateInYesterday(value) {
            return "Yesterday"
        } else {
            return dateFormatter.string(from: value)
        }
    }
}
