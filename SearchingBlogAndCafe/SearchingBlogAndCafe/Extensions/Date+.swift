//
//  Date+.swift
//  SearchingBlogAndCafe
//
//  Created by apple on 2021/07/09.
//

import Foundation


extension Date {
    // Use for Decodable Date Parsing
    static func parse<K: CodingKey>(_ values: KeyedDecodingContainer<K>, key: K) -> Date? {
        guard let dateString = try? values.decode(String.self, forKey: key),
            let date = from(dateString) else {
            return nil
        }
        
        return date
    }
    
    static func from(_ dateString: String?) -> Date? {
        guard let dateString = dateString else { return nil }
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        dateFormatter.locale = Locale(identifier: "ko_kr")
        if let date = dateFormatter.date(from: dateString) {
            return date
        }

        return nil
    }
}
