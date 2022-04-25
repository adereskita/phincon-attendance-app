//
//  OnBoardingModels.swift
//  phincon-attendance-app
//
//  Created by Ade on 3/10/22.
//

import UIKit

// MARK: - Onboarding
struct Onboarding: Codable {
    var id, image, title, onboardingDescription: String?
    var createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case image, title
        case onboardingDescription = "description"
        case createdAt, updatedAt
        case v = "__v"
    }
}


