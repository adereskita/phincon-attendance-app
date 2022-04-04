//
//  RegisterInteractor.swift
//  phincon-attendance-app
//
//  Created by Sri Endah Ramurti on 01/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol RegisterBusinessLogic
{
  func doSomething(request: RegisterModels.Post.Request)
}

protocol RegisterDataStore
{
  //var name: String { get set }
}

class RegisterInteractor: RegisterBusinessLogic, RegisterDataStore
{
  var presenter: RegisterPresentationLogic?
  var worker: RegisterWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: RegisterModels.Post.Request)
  {
    worker = RegisterWorker()
    worker?.postRegisterUser()
    
    let response = RegisterModels.Post.Response()
    presenter?.presentSomething(response: response)
  }
}
