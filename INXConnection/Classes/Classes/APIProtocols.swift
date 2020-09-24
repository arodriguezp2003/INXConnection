//
//  APIProtocols.swift
//  INXConnection
//
//  Created by arodriguez on 24-09-20.
//

import Foundation

public enum APIManagerServiceError {
    case INVALID_RESPONSE
    case ENCODE_ERROR
    case DECODE_ERROR
    case AUTH
    case NO_PARAMS
    case ERROR_URL
    case NO_PAYLOAD
    case BACKEND_ERROR
}

public struct APIManagerError: Error {
    public let error: APIManagerServiceError
    public let message: String
    public let statusCode: String
    
    init(_ error: APIManagerServiceError, _ statusCode: String = "-1") {
        self.error = error
        self.message = ""
        self.statusCode = statusCode
    }
    
    init(_ error: APIManagerServiceError, message: String, _ statusCode: String = "-1") {
        self.error = error
        self.message = message
        self.statusCode = statusCode
    }
}
