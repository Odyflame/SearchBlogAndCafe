//
//  DocumentData.swift
//  SearchingBlogAndCafe
//
//  Created by apple on 2021/07/06.
//

import Foundation
import Network

enum DataType: String{
    case all = "All"
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
    
    init(title: String?, contents: String?, url: URL?, cafeName: String?, blogName: String?, thumbnailURL: URL?, datetime: Date?) {
        self.title = title
        self.contents = contents
        self.url = url
        self.thumbnailURL = thumbnailURL
        self.datetime = datetime
        
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
        self.url = docs.url
        self.thumbnailURL = docs.thumbnailURL
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
