//
//  ResponseServer.swift
//  phincon-attendance-app
//
//  Created by Ade on 4/5/22.
//

import Foundation

// MARK: - Error handling
struct ResponseError: Error, Decodable {
    let error: APIError
}
struct APIError: Error, Decodable {
    let status: Int
    var message: String?
}

// MARK: - Success
struct Success: Codable {
    var status: Int?
    var message, token: String?
}
enum LoggedIn {
    struct Success<T: Codable>: Codable {
        var status: Int?
        var message: String?
        var result: T?
    }
}
