//
//  LoginPresenter.swift
//  phincon-attendance-app
//
//  Created by Sri Endah Ramurti on 23/03/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LoginPresentationLogic {
    func interactor(didSuccessLogin response: LoginModels.Post.Response)
    func interactor(didFailLogin error: String)
}

class LoginPresenter: LoginPresentationLogic {
    
    weak var viewController: LoginDisplayLogic?
  
  // MARK: Do something
  
    func interactor(didSuccessLogin response: LoginModels.Post.Response) {                
        let viewModel = LoginModels.Post.ViewModel(token: response.success.token)
        viewController?.presenter(displayLoginSuccess: viewModel)
    }
    
    func interactor(didFailLogin error: String) {
        viewController?.presenter(didFailLogin: error)
    }
}
