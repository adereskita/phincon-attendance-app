//
//  SplashScreenViewController.swift
//  phincon-attendance-app
//
//  Created by Ade on 4/25/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Kingfisher
import SwiftKeychainWrapper

protocol SplashScreenDisplayLogic: AnyObject {
  func presenter(displaySplashScreen response: SplashScreenModels.Fetch.Response)
}

class SplashScreenVC: UIViewController, SplashScreenDisplayLogic {

    var interactor: SplashScreenBusinessLogic?
    var router: (NSObjectProtocol & SplashScreenRoutingLogic & SplashScreenDataPassing)?

    // MARK: Object lifecycle
      
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
      
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setup()
    }
      
    // MARK: Setup
      
    private func setup() {
        let viewController = self
        let interactor = SplashScreenInteractor()
        let presenter = SplashScreenPresenter()
        let router = SplashScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
      
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
      
      // MARK: View lifecycle
      
    override func viewWillAppear(_ animated: Bool) {
        let request = SplashScreenModels.Fetch.Request()
        interactor?.loadSplashScreen(request: request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.splashTimeOut(sender:)), userInfo: nil, repeats: false)
    }
      
    // MARK: Do something
    
    let keyChainWrapper = KeychainWrapper.standard
      
    @IBOutlet weak var logoImgView: UIImageView!
      
    func setupUI() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.splashTimeOut()
        })
    }
    
    func presenter(displaySplashScreen response: SplashScreenModels.Fetch.Response) {
        let imgUrl = URL(string: response.success.result!.image!.path!)
        logoImgView.kf.setImage(with: imgUrl)
    }
    
    func splashTimeOut() {
        // if user is logged in before
        if keyChainWrapper.string(forKey: "user_token") != nil {
            router?.routeToDashboard(segue: nil)
        } else {
            // if user isn't logged in
            router?.routeToOnboarding(segue: nil)
        }
    }
        
}
