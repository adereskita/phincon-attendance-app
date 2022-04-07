//
//  User.swift
//  phincon-attendance-app
//
//  Created by Ade on 4/7/22.
//

import Foundation

// MARK: - Result
struct Users: Codable {
    var id, username, password, fullname: String?
    var idcardnumber: Int?
    var address, image: String?
    var location: [Location]?
    var createdAt, updatedAt, v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username, password, fullname, idcardnumber, address, image, location, createdAt, updatedAt
        case v = "__v"
    }
}

// MARK: - Location
struct Location: Codable {
    var name, address, latitude, longitude: String?
    var image, id: String?

    enum CodingKeys: String, CodingKey {
        case name, address, latitude, longitude, image
        case id = "_id"
    }
}
