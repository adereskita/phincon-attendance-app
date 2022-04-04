//
//  RegisterViewController.swift
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

protocol RegisterDisplayLogic: AnyObject
{
  func displaySomething(viewModel: RegisterModels.Post.ViewModel)
}

class RegisterViewController: UIViewController, RegisterDisplayLogic
{
  var interactor: RegisterBusinessLogic?
  var router: (NSObjectProtocol & RegisterRoutingLogic & RegisterDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = RegisterInteractor()
    let presenter = RegisterPresenter()
    let router = RegisterRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
    setupUI()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet var cardView: UIView!
    @IBOutlet var registerBtn: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var pass1TextField: UITextField!
    @IBOutlet weak var pass2TextField: UITextField!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    @IBAction func registerButton(_sender: Any){
        spinnerSetup()
//        router?.routeToLogin(segue: nil)
    }
    @IBAction func loginButton(_sender: Any){
        router?.routeToLogin(segue: nil)
    }
    
    func setupUI() {
        spinner.isHidden = true
        registerBtn.layer.cornerRadius = 10
        
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOffset = CGSize.zero
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowRadius = 3.0
        cardView.layer.cornerRadius = 25
        cardView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func spinnerSetup() {
        spinner.isHidden = false
        spinner.style = .medium
        spinner.backgroundColor = UIColor(white: 0.9, alpha: 0.6)
        spinner.layer.cornerRadius = 10.0
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()

        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.spinner.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if let route = self.router {
                    route.routeToLogin(segue: nil)
                }
            }
        }
    }
    
  func doSomething()
  {
//    let request = RegisterModels.Post.Request()
//    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: RegisterModels.Post.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
}
