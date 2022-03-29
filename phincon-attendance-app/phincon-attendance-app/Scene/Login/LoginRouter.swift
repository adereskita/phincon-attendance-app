//
//  LoginRouter.swift
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

@objc protocol LoginRoutingLogic {
  func routeToDashboardPage(segue: UIStoryboardSegue?)
}

protocol LoginDataPassing {
  var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {
    
  weak var viewController: LoginViewController?
  var dataStore: LoginDataStore?
    
    func routeToDashboardPage(segue: UIStoryboardSegue?) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let dashBoardVC = storyBoard.instantiateViewController(withIdentifier: "TabBarController")
        dashBoardVC.modalPresentationStyle = .fullScreen
        navigateToSomewhere(source: viewController!, destination: dashBoardVC as! UITabBarController)
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
  
  func navigateToSomewhere(source: LoginViewController, destination: UITabBarController) {
    source.show(destination, sender: nil)
  }
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: LoginDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
