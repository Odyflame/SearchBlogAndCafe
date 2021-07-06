//
//  Cafe.swift
//  Network
//
//  Created by apple on 2021/07/05.
//

import Foundation

protocol BaseResponse {
    var meta: Meta { get }
    var documents: [Document] { get }
}

public struct Cafe: Codable, BaseResponse {
    public var meta: Meta
    public var documents: [Document]
}
