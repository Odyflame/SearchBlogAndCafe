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
    let datetime: Date?
    let type: DataType?
    
    init(title: String?, contents: String?, url: String?, cafeName: String?, blogName: String?, thumbnailURL: String?, datetime: String?) {
        self.title = String.parse(value: title)
        self.contents = String.parse(value: contents)
        
        self.url = URL.parse(url)
        self.thumbnailURL =  URL.parse(thumbnailURL)
        
        self.datetime = Date.from(datetime)
        
        guard let cafeName = cafeName else {
            self.name = String.parse(value: blogName)
            self.type = .blog
            return
        }
        
        self.name = String.parse(value: cafeName)
        self.type = .cafe
    }
    
    init(docs: Document) {
        self.title = String.parse(value: docs.title)
        self.contents = String.parse(value: docs.contents)
        self.url =  URL.parse(docs.url)
        self.thumbnailURL =  URL.parse(docs.thumbnailURL)
        self.datetime = Date.from(docs.datetime)
        
        guard let cafeName = docs.cafeName else {
            self.name = String.parse(value: docs.blogName)
            self.type = .blog
            return
        }
        self.name = String.parse(value: docs.cafeName)
        self.type = .cafe
    }
}
