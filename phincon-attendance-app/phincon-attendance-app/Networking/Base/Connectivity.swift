//
//  Connectivity.swift
//  phincon-attendance-app
//
//  Created by Ade on 4/21/22.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
