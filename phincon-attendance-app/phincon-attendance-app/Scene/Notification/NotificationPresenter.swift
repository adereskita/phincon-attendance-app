//
//  NotificationPresenter.swift
//  phincon-attendance-app
//
//  Created by Ade on 3/29/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol NotificationPresentationLogic {
    func presentNotificationList(response: NotificationModels.FetchNotification.Response)
}

class NotificationPresenter: NotificationPresentationLogic {
    weak var viewController: NotificationDisplayLogic?
  
  // MARK: Do something
  
    func presentNotificationList(response: NotificationModels.FetchNotification.Response) {
//        let viewModel = NotificationModels.FetchNotification.ViewModel()
        let response = NotificationModels.FetchNotification.Response(notificationData: response.notificationData)
        viewController?.displayNotificationList(response: response)
    }
}
