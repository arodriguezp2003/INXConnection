//
//  INXResponse.swift
//  INXConnection
//
//  Created by arodriguez on 24-09-20.
//

import Foundation

public struct APIResponse<T:Decodable>: Decodable {
    let code: String
    let description: String?
    let payload: T?
}
