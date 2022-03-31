//
//  ForgotPasswordRouter.swift
//  phincon-attendance-app
//
//  Created by Sri Endah Ramurti on 30/03/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol ForgotPasswordRoutingLogic
{
  func routeToLoginPage(segue: UIStoryboardSegue?)
}

protocol ForgotPasswordDataPassing
{
  var dataStore: ForgotPasswordDataStore? { get }
}

class ForgotPasswordRouter: NSObject, ForgotPasswordRoutingLogic, ForgotPasswordDataPassing
{
  weak var viewController: ForgotPasswordViewController?
  var dataStore: ForgotPasswordDataStore?
    
    func routeToLoginPage(segue: UIStoryboardSegue?) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let dashBoardVC = storyBoard.instantiateViewController(withIdentifier: "LoginPage")
        dashBoardVC.modalPresentationStyle = .fullScreen
        navigateToSomewhere(source: viewController!, destination: dashBoardVC as! LoginViewController)
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
  
  func navigateToSomewhere(source: ForgotPasswordViewController, destination: LoginViewController)
  {
    source.show(destination, sender: nil)
  }
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: ForgotPasswordDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
