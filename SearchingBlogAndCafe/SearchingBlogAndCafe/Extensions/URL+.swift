//
//  URL+.swift
//  SearchingBlogAndCafe
//
//  Created by apple on 2021/07/09.
//

import Foundation

extension URL {
    static func parse<T: CodingKey>(_ values: KeyedDecodingContainer<T>, key: T) -> URL? {
        guard let decodedURL = try? values.decode(String.self, forKey: key),
            let url = URL(string: decodedURL) else {
                return nil
        }
        
        return url
    }
    
    static func parse(_ value: String?) -> URL? {
        guard let value = value,
              let url = URL(string: value) else {
                return nil
        }
        
        return url
    }
}
