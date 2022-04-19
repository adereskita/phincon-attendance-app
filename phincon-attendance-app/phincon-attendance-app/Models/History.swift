//
//  History.swift
//  phincon-attendance-app
//
//  Created by Ade on 3/15/22.
//

import Foundation
import UIKit

struct HistoryFilter {
    var day: String?
}

// MARK: - History
struct History: Codable {
    var id, user, activity, locationName: String?
    var locationAddress, locationImage, createdAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case user, activity, locationName, locationAddress, locationImage, createdAt
        case v = "__v"
    }
}

//struct History {
//    var title: String?
//    var desc: String?
//    var type: String?
//    var time: String?
//    var image: UIImage?
//}
