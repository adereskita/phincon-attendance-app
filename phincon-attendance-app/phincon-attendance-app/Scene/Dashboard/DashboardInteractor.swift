//
//  DashboardInteractor.swift
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

protocol DashboardBusinessLogic {
    func loadCheckInList(request: DashboardModels.GetLocation.Request)
    func loadCheckOutList(request: DashboardModels.GetLocation.Request)
    func checkLoginSession(request: DashboardModels.IsLogin.Request)
    func checkIn(request: DashboardModels.CheckLocation.Request)
    func checkOut(request: DashboardModels.CheckLocation.Request)
}

protocol DashboardDataStore {
  var token: String { get set }
}

class DashboardInteractor: DashboardBusinessLogic, DashboardDataStore {

    var presenter: DashboardPresentationLogic?
    var worker = DashboardWorker()
    let userDefault = UserDefaults.standard
    
    var token: String = ""

  // MARK: Do something
    func checkOut(request: DashboardModels.CheckLocation.Request) {
        token = userDefault.string(forKey: "user_token")!
    }
    
    func checkIn(request: DashboardModels.CheckLocation.Request) {
        token = userDefault.string(forKey: "user_token")!
        worker.checkIn(location: request.location!, token: token, completionHandler: { result in
            switch result {
            case .success(let value):
                self.presenter?.interactor(CheckIn: value)
            case .failure(let error):
                print(error.status, error.message!)
            }
        })
    }
    
    func loadCheckInList(request: DashboardModels.GetLocation.Request) {
        token = userDefault.string(forKey: "user_token")!
        worker.getLocation(token: token, completionHandler: { (result) in
            switch result {
            case .success(let value):
                self.presenter?.interactor(CheckInList: value)
                
            case .failure(let error):
                print(error.status, error.message!)
            }
        })
    }
    
    func loadCheckOutList(request: DashboardModels.GetLocation.Request) {
        token = userDefault.string(forKey: "user_token")!
        worker.getLocation(token: token, completionHandler: { (result) in
            switch result {
            case .success(let value):
                self.presenter?.interactor(CheckOutList: value)
            case .failure(let error):
                print(error.status, error.message!)
            }
        })
    }
    
    func checkLoginSession(request: DashboardModels.IsLogin.Request) {
        token = userDefault.string(forKey: "user_token")!
        worker.loginSession(token: token, completionHandler: { (result) in
            
            switch result {
            case .success(_):
                print("logged in")
                
            case .failure(let error):
                print("not log in")
                self.presenter?.interactor(didExpiredSession: error.status, message: error.message!)
            }
        })
    }
}
