//
//  INXResponse.swift
//  INXConnection
//
//  Created by arodriguez on 24-09-20.
//

import Foundation

public struct APIResponse<T:Decodable>: Decodable {
    let status: String
    let message: String?
    let data: T?
}
