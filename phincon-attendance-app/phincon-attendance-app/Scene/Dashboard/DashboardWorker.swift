//
//  DashboardWorker.swift
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

protocol DashboardWorkerProtocol: AnyObject {
    func loginSession(token: String, completionHandler: @escaping (Result<DashboardModels.IsLogin.Response, APIError>) -> Void)
    func getLocation(token: String, completionHandler: @escaping (Result<DashboardModels.IsLogin.location.Response, APIError>) -> Void)
//    func postLogin(username: String, password:String, success: @escaping(_ response: LoginModels.Post.Response) -> Void, fail:@escaping(_ message: String) -> Void)
}

class DashboardWorker: DashboardWorkerProtocol {
    
    // MARK: - Private Properties
    private var service: ClientAPIProtocol
    
    // MARK: - Init
    init(_ service: ClientAPIProtocol = ClientAPI()) {
        self.service = service
    }
    
    func getLocation(token: String, completionHandler: @escaping (Result<DashboardModels.IsLogin.location.Response, APIError>) -> Void) {
        service.getLocation(token: token, completionHandler: {result in
            switch result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(APIError(status: error.status, message: error.message)))
            }
        })
    }
    
    func loginSession(token: String, completionHandler: @escaping (Result<DashboardModels.IsLogin.Response, APIError>) -> Void) {
        service.loginSession(token: token, completionHandler: { result in
            switch result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(APIError(status: error.status, message: error.message)))
            }
        })
    }
    
    var checkInLists = [Checkin]()
    var checkOutLists = [Checkin]()

    func fetchDashboardListIn() -> [Checkin] {
        checkInLists = [
            Checkin(title: "PT. Phincon",
                            description: "Office. 88 @Kasablanka Office Tower 18th Floor", image: #imageLiteral(resourceName: "dashboard-list-1")),
            Checkin(title: "Telkomsel Smart Office", description: "Jl. Jend. Gatot Subroto Kav. 52. Jakarta Selatan", image: #imageLiteral(resourceName: "dashboard-list-2")),
            Checkin(title: "Rumah", description: "Jakarta", image: #imageLiteral(resourceName: "dashboard-list-3"))
        ]
        return checkInLists
    }
    
    func fetchDashboardListOut() ->[Checkin] {
        checkOutLists = [
            Checkin(title: "PT. Phincon",
                            description: "Office. 88 @Kasablanka Office Tower 18th Floor", image: #imageLiteral(resourceName: "dashboard-list-1"))
        ]
        return checkOutLists
    }
}
