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
    func routeToLogin(segue: UIStoryboardSegue?)
    func routeToSignUp(segue: UIStoryboardSegue?)
}

protocol OnBoardingDataPassing {
    var dataStore: OnBoardingDataStore? { get }
}

class OnBoardingRouter: NSObject, OnBoardingRoutingLogic, OnBoardingDataPassing {
    weak var viewController: OnBoardingViewController?
    var dataStore: OnBoardingDataStore?
  
  // MARK: Routing
    func routeToLogin(segue: UIStoryboardSegue?) {
        let loginVC = LoginViewController()
//        let loginVC = UIViewController(nibName: "LoginViewController", bundle: nil)
        
//        self.definesPresentationContext = true
//        loginVC.modalPresentationStyle = .fullScreen
        navigateToLogin(source: viewController!, destination: loginVC)
    }
    
    func routeToSignUp(segue: UIStoryboardSegue?) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let destinationVC = storyBoard.instantiateViewController(identifier: "RegisterVC") as! RegisterViewController
//            navigateToSignUp(source: viewController!, destination: destinationVC)
        let registerVC = RegisterViewController()
        navigateToSignUp(source: viewController!, destination: registerVC)
    }

  // MARK: Navigation
    
    func navigateToLogin(source: OnBoardingViewController, destination: UIViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
//        source.present(destination, animated:true, completion:nil)
    }
    
    func navigateToSignUp(source: OnBoardingViewController, destination: RegisterViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: Passing data
    
//    func passDataToLogin(source: LoginDataStore, destination: inout SomewhereDataStore)
//    {
//      destination.name = source.name
//    }
}
