//
//  SceneDelegate.swift
//  phincon-attendance-app
//
//  Created by Satriya on 10/03/22.
//

import UIKit
import SwiftKeychainWrapper

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let keyChainWrapper = KeychainWrapper.standard

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
//        if let windowScene = scene as? UIWindowScene{
//
//            let window = UIWindow(windowScene: windowScene)
//            let rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SplashScreenVC") as! SplashScreenVC
//
//            window.rootViewController = rootViewController
//            self.window = window
//            window.makeKeyAndVisible()
//        }
        
        // MARK: Clear Keychain if the App is Fresh Installed
        self.clearKeychainIfFreshInstall()
        
        // MARK: Code below to give session alike.
        // if user has logged in previously, present the DashboardVC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // if user is logged in before
        if keyChainWrapper.string(forKey: "user_token") != nil {
            
//            let dashBoardVC = storyboard.instantiateViewController(withIdentifier: "TabBarController")
//            let navDashboard = UINavigationController(rootViewController: dashBoardVC)
//            window?.rootViewController = navDashboard
        } else {
            // if user isn't logged in
//            let onboardingVC = storyboard.instantiateViewController(identifier: "NavigationController")
//            let navOnboard = UINavigationController(rootViewController: onboardingVC)
//            window?.rootViewController = navOnboard
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
    func clearKeychainIfFreshInstall() {
        let freshInstall = !UserDefaults.standard.bool(forKey: "alreadyInstalled")
        if freshInstall {
            keyChainWrapper.removeObject(forKey: "user_token")
            UserDefaults.standard.set(true, forKey: "alreadyInstalled")
      }
    }
    
    func changeRootViewController(_ vc: UIViewController, animated: Bool) {
        guard let window = self.window else {
            return
        }
        // change the root view controller to your specific view controller
        window.rootViewController = vc
        
        if animated {
            window.rootViewController = vc
            UIView.transition(with: window,
                              duration: 0.5,
                              options: [.transitionCrossDissolve],
                              animations: nil,
                              completion: nil)
        }
    }
    
    
}

