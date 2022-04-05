//
//  ResponseServer.swift
//  phincon-attendance-app
//
//  Created by Ade on 4/5/22.
//

import Foundation

// MARK: - Error handling
struct ErrorStatus: Error {
    let status: Int
    var message: String?
}

// MARK: - Success
struct Success: Codable {
    var status: Int?
    var message, token: String?
}
