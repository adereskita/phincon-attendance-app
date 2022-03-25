//
//  OnBoardingRouter.swift
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

@objc protocol OnBoardingRoutingLogic {
    func routeToDashboard(segue: UIStoryboardSegue?)
}

protocol OnBoardingDataPassing {
    var dataStore: OnBoardingDataStore? { get }
}

class OnBoardingRouter: NSObject, OnBoardingRoutingLogic, OnBoardingDataPassing {
    weak var viewController: OnBoardingViewController?
    var dataStore: OnBoardingDataStore?
  
  // MARK: Routing
    func routeToDashboard(segue: UIStoryboardSegue?) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let dashboardVC = storyBoard.instantiateViewController(withIdentifier: "TabBarController")
        let dashboardVC = storyBoard.instantiateViewController(withIdentifier: "LoginPage")
//        self.definesPresentationContext = true
        dashboardVC.modalPresentationStyle = .fullScreen
        navigateToSomewhere(source: viewController!, destination: dashboardVC as! LoginViewController)
        
  }

  // MARK: Navigation
    
    func navigateToSomewhere(source: OnBoardingViewController, destination: LoginViewController) {
        source.show(destination, sender: nil)
//        source.present(destination, animated:true, completion:nil)

    }
}
