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
    let name: String?
    let thumbnailURL: URL?
    let datetime: Date?
    
    init(title: String?, contents: String?, url: URL?, cafeName: String?, blogName: String?, thumbnailURL: URL?, datetime: Date?) {
        self.title = title
        self.contents = contents
        self.url = url
        self.thumbnailURL = thumbnailURL
        self.datetime = datetime
        
        if let cafeName = cafeName {
            self.name = cafeName
        } else {
            self.name = blogName
        }
        
        guard let cafeName = cafeName else {
            self.name = blogName
            return
        }
        self.name = cafeName
    }
    
    init(docs: Document) {
        self.title = docs.title
        self.contents = docs.contents
        self.url = docs.url
        self.thumbnailURL = docs.thumbnailURL
        self.datetime = docs.datetime
        
        guard let cafeName = docs.cafeName else {
            self.name = docs.blogName
            return
        }
        self.name = docs.cafeName
    }
}
