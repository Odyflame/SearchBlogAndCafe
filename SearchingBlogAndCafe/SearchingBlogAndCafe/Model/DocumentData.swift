//
//  DocumentData.swift
//  SearchingBlogAndCafe
//
//  Created by apple on 2021/07/06.
//

import Foundation
import Network

enum DataType: String{
    case blog = "Blog"
    case cafe = "Cafe"
}

enum SortType: String {
    case accuracy = "accuracy"
    case recency = "recency"
}

public struct DocumentData {
    let title: String?
    let contents: String?
    let url: URL?
    let name: String?
    let thumbnailURL: URL?
    let datetime: String?
    let type: DataType?
    
    init(title: String?, contents: String?, url: String?, cafeName: String?, blogName: String?, thumbnailURL: String?, datetime: String?) {
        self.title = String.parse(value: title)
        self.contents = String.parse(value: contents)
        self.datetime = String.parse(value: datetime)
        self.url = URL.parse(url)
        self.thumbnailURL =  URL.parse(thumbnailURL)
        
        guard let cafeName = cafeName else {
            self.name = blogName
            self.type = .blog
            return
        }
        
        self.name = cafeName
        self.type = .cafe
    }
    
    init(docs: Document) {
        self.title = docs.title
        self.contents = docs.contents
        self.url =  URL.parse(docs.url)
        self.thumbnailURL =  URL.parse(docs.thumbnailURL)
        self.datetime = docs.datetime
        
        guard let cafeName = docs.cafeName else {
            self.name = docs.blogName
            self.type = .blog
            return
        }
        self.name = docs.cafeName
        self.type = .cafe
    }
}
