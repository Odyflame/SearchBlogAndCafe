//
//  DocumentData.swift
//  SearchingBlogAndCafe
//
//  Created by apple on 2021/07/06.
//

import Foundation
import Network

public struct DocumentData {
    let title: String?
    let contents: String?
    let url: URL?
    let cafeName: String?
    let blogName: String?
    let thumbnailURL: URL?
    let datetime: Date?
    
    init(title: String?, contents: String?, url: URL?, cafeName: String?, blogName: String?, thumbnailURL: URL?, datetime: Date?) {
        self.title = title
        self.contents = contents
        self.url = url
        self.cafeName = cafeName
        self.blogName = blogName
        self.thumbnailURL = thumbnailURL
        self.datetime = datetime
    }
    
    init(docs: Document) {
        self.title = docs.title
        self.contents = docs.contents
        self.url = docs.url
        self.cafeName = docs.cafeName
        self.blogName = docs.blogName
        self.thumbnailURL = docs.thumbnailURL
        self.datetime = docs.datetime
    }
}
