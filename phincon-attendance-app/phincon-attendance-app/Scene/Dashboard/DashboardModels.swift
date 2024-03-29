//
//  DashboardModels.swift
//  phincon-attendance-app
//
//  Created by Ade on 3/24/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum DashboardModels {
  // MARK: Use cases
  
    enum IsLogin {
        struct Request {}
        struct Response: Codable {
            let success: LoggedIn.Success<Users>
        }
    }
    enum CheckLocation {
        struct Request {
            var location: String?
        }
        struct Response: Codable {
            let success: Success
        }
    }
    
    enum GetLocation {
        struct Request {}
        struct Response: Codable {
            let success: LoggedIn.Success<[Location]> // user [ ] since the data api is array
        }
    }
    
    struct ViewModel {
        var activity: String?
    }
//    enum LoadCheckInOut {
//        struct Request {}
//        struct Response {
//            var checkInData: [Checkin]
//        }
//        struct ViewModel {
//            let title: String
//            let description: String
//            let image: UIImage
//        }
//    }
}
