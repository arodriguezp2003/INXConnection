//
//  Mockup.swift
//  INXConnection_Example
//
//  Created by arodriguez on 24-09-20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import OHHTTPStubs
class Mockup {
    
    func get(uri: String) {
        stub(condition: isHost("dummy.restapiexample.com") && isPath(uri)) { _ in
            let stubPath = OHPathForFile("get.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
    }
}
