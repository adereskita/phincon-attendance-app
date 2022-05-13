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
import SwiftKeychainWrapper

@objc protocol LoginRoutingLogic {
    func routeToDashboardPage(segue: UIStoryboardSegue?)
    func routeToForgotPassword(segue: UIStoryboardSegue?)
    func routeToRegister(segue: UIStoryboardSegue?)
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {
    
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    let userDefault = UserDefaults.standard
    let keyChainWrapper = KeychainWrapper.standard
    
    // MARK: Routing
    
    func routeToDashboardPage(segue: UIStoryboardSegue?) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let dashBoardVC = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        
        if let token = dataStore?.token {
            keyChainWrapper.set(token, forKey: "user_token")
            
            let tabbarVC = TabBarViewController()
            navigateToDashboard(source: viewController!, destination: tabbarVC)
        }
        //    passDataToDashboard(source: dataStore!, destination: &destinationDS)
    }
    func routeToForgotPassword(segue: UIStoryboardSegue?) {
        let forgotPassVC = ForgotPasswordViewController()
        navigateToForgotPass(source: viewController!, destination: forgotPassVC)
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let dashBoardVC = storyBoard.instantiateViewController(withIdentifier: "ForgotPassword") as! ForgotPasswordViewController
//        dashBoardVC.modalPresentationStyle = .fullScreen
//        navigateToForgotPass(source: viewController!, destination: dashBoardVC)
    }
    func routeToRegister(segue: UIStoryboardSegue?) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        
//        let dashBoardVC = storyBoard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
//        dashBoardVC.modalPresentationStyle = .fullScreen
//        navigateToRegister(source: viewController!, destination: dashBoardVC)
//        
        let registerVC = RegisterViewController()
        navigateToRegister(source: viewController!, destination: registerVC)
    }
    
    // MARK: Navigation
    
    func navigateToDashboard(source: LoginViewController, destination: UITabBarController) {
        let navCon = UINavigationController(rootViewController: destination)
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(navCon, animated: false)
    }
    
    func navigateToForgotPass(source: LoginViewController, destination: ForgotPasswordViewController) {
        source.show(destination, sender: nil)
    }
    
    func navigateToRegister(source: LoginViewController, destination: RegisterViewController) {
        if userDefault.bool(forKey: "isLogin") == true {
            source.show(destination, sender: nil)
        } else {
            source.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: Passing data
    
//    func passDataToDashboard(source: LoginDataStore, destination: inout SomewhereDataStore) {
//      destination.name = source.name
//    }
}
