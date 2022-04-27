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
      
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.splashTimeOut(sender:)), userInfo: nil, repeats: false)
        setupUI()
    }
      
    // MARK: Do something
      
    @IBOutlet weak var logoImgView: UIImageView!
      
    func setupUI() {
        let request = SplashScreenModels.Fetch.Request()
        interactor?.loadSplashScreen(request: request)
    }
    
    func presenter(displaySplashScreen response: SplashScreenModels.Fetch.Response) {
        let imgUrl = URL(string: response.success.result!.image!.path!)
        logoImgView.kf.setImage(with: imgUrl)
    }
    
    @objc func splashTimeOut(sender : Timer){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dashBoardVC = storyboard.instantiateViewController(withIdentifier: "TabBarController")
        let navDashboard = UINavigationController(rootViewController: dashBoardVC)
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(navDashboard)
    }
}