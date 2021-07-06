//
//  Blog.swift
//  Network
//
//  Created by apple on 2021/07/05.
//

import Foundation

public struct Blog: Codable, BaseResponse {
    public var meta: Meta
    public var documents: [Document]
}
