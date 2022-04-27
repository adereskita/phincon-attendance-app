//
//  SplashScreenInteractor.swift
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

protocol SplashScreenBusinessLogic {
    func loadSplashScreen(request: SplashScreenModels.Fetch.Request)
}

protocol SplashScreenDataStore {
  //var name: String { get set }
}

class SplashScreenInteractor: SplashScreenBusinessLogic, SplashScreenDataStore {
      var presenter: SplashScreenPresentationLogic?
      var worker = SplashScreenWorker()
  //var name: String = ""
  
  // MARK: Do something
  
    func loadSplashScreen(request: SplashScreenModels.Fetch.Request) {
        worker.getSplashScreen(completionHandler: { result in
            switch result {
            case .success(let value):
                self.presenter?.interactor(displaySplashScreen: value)
            case .failure(let error):
                print(error.status, error.message!)
            }
        })
    }
}