//
//  SplashScreenPresenter.swift
//  phincon-attendance-app
//
//  Created by Ade on 4/25/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SplashScreenPresentationLogic {
    func interactor(displaySplashScreen response: SplashScreenModels.Fetch.Response)
}

class SplashScreenPresenter: SplashScreenPresentationLogic {
    
    weak var viewController: SplashScreenDisplayLogic?
  
  // MARK: Do something
    
    func interactor(displaySplashScreen response: SplashScreenModels.Fetch.Response) {
        viewController?.presenter(displaySplashScreen: response)
    }
}
