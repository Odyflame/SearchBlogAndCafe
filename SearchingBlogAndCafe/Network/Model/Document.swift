//
//  Document.swift
//  Network
//
//  Created by apple on 2021/07/05.
//

import Foundation

public struct Document: Codable {
    public var title: String?
    public var contents: String?
    public var url: URL?
    public var cafeName: String?
    public var blogName: String?
    public var thumbnailURL: URL?
    public var datetime: Date?
    
    init(title: String?, contents: String?, url: URL?, cafeName: String?, blogName: String?, thumbnailURL: URL?, datetime: Date?) {
        self.title = title
        self.contents = contents
        self.url = url
        self.cafeName = cafeName
        self.blogName = blogName
        self.thumbnailURL = thumbnailURL
        self.datetime = datetime
    }
    
    enum CodingKeys: String, CodingKey {
        case title, contents, url, datetime
        case thumbnailURL = "thumbnail"
        case cafeName = "cafename"
        case blogName = "blogname"
    }
}
