//
//  RegisterRouter.swift
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

@objc protocol RegisterRoutingLogic
{
    func routeToLogin(segue: UIStoryboardSegue?)
    func routeDidRegister(segue: UIStoryboardSegue?)
}

protocol RegisterDataPassing
{
  var dataStore: RegisterDataStore? { get }
}

class RegisterRouter: NSObject, RegisterRoutingLogic, RegisterDataPassing {
    weak var viewController: RegisterViewController?
    var dataStore: RegisterDataStore?
    let userDefault = UserDefaults.standard
  
    func routeToLogin(segue: UIStoryboardSegue?) {
        let loginVC = LoginViewController()
        navigateToLogin(source: viewController!, destination: loginVC)
    }
    
    func routeDidRegister(segue: UIStoryboardSegue?) {
        let loginVC = LoginViewController()
        navigateToLogin(source: viewController!, destination: loginVC)
    }
  // MARK: Routing
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  func navigateToLogin(source: RegisterViewController, destination: LoginViewController)
  {
    if userDefault.bool(forKey: "isLogin") == true {
        source.navigationController?.popViewController(animated: true)
    } else {
        source.show(destination, sender: nil)
    }
  }
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: RegisterDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
