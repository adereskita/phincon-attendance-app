//
//  File.swift
//  phincon-attendance-app
//
//  Created by Sri Endah Ramurti on 24/03/22.
//

import Foundation
import UIKit

struct Profile {
    var titleData : String?
    var descData : String?
    var iconData : UIImage?
}

struct ProfileImage {
    var name : String?
    var role : String?
    var image : UIImage?
}

struct User: Codable {
    var username: String?
    var password: String?
    var fullname: String?
    var idcardnumber: String?
}
