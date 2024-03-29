//
//  HistoryModels.swift
//  phincon-attendance-app
//
//  Created by Ade on 3/22/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum HistoryModels {
    
    enum FetchHistory {
        struct Request{
            var log: String?
        }
        struct Response: Codable {
            let success: HistoryResponse.Success<[History]>
        }
    }
}
