//
//  SplashScreen.swift
//  phincon-attendance-app
//
//  Created by Ade on 4/25/22.
//

import Foundation

// MARK: - SplashScreen
struct SplashScreen: Codable {
    var image: SplashImage?
}

// MARK: - Image
struct SplashImage: Codable {
    var name: String?
    var path: String?
}
