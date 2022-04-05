//
//  RegisterModels.swift
//  phincon-attendance-app
//
//  Created by Sri Endah Ramurti on 01/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum RegisterModels {
  // MARK: Use cases
  
    enum Post{
    // Request - parameters that need to be sent to the API request.
        struct Request {
            var username: String?
            var password: String?
            var fullname: String?
            var idcardnumber: String?
        }
        struct Response: Codable {
            let success: Success
        }
        struct ResponseFail {
            var error: ErrorStatus?
        }
        struct ViewModel {
            var message: String?
        }
    }
}
