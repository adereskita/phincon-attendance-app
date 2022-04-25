//
//  OnBoardingPresenter.swift
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

protocol OnBoardingPresentationLogic {
    func interactor(displayOnboard response: OnBoardingModels.FetchOnBoarding.Response)
}

class OnBoardingPresenter: OnBoardingPresentationLogic {
    
    weak var viewController: OnBoardingDisplayLogic?
  
  // MARK: Do something
    
    func interactor(displayOnboard response: OnBoardingModels.FetchOnBoarding.Response) {
        viewController?.presenter(displayOnboard: response)
    }
}
