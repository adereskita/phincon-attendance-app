//
//  DashboardPresenter.swift
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

protocol DashboardPresentationLogic {
    func presentDashboardListIn(response: DashboardModels.LoadCheckInOut.Response)
    func presentDashboardListOut(response: DashboardModels.LoadCheckInOut.Response)
}

class DashboardPresenter: DashboardPresentationLogic {
  weak var viewController: DashboardDisplayLogic?
  
  // MARK: Do something
  
    func presentDashboardListIn(response: DashboardModels.LoadCheckInOut.Response) {
//        let viewModel = DashboardModels.LoadCheckInOut.ViewModel()
        let response = DashboardModels.LoadCheckInOut.Response(checkInData: response.checkInData)
        viewController?.displayDashboardListIn(response: response)
    }
    
    func presentDashboardListOut(response: DashboardModels.LoadCheckInOut.Response) {
        let response = DashboardModels.LoadCheckInOut.Response(checkInData: response.checkInData)
        viewController?.displayDashboardListOut(response: response)
    }
}