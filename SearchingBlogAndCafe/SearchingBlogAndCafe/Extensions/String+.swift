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
}
