//
//  LoginViewController.swift
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

protocol LoginDisplayLogic: AnyObject {
    func displaySomething(viewModel: Login.Something.ViewModel)
}

class LoginViewController: UIViewController, LoginDisplayLogic {
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
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
        doSomething()
        setupUI()
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var cardView: UIView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    @IBAction func dismissButton(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func loginButton(_ sender: Any) {
        spinnerSetup()
    }
    
    func setupUI() {
        spinner.isHidden = true
        loginBtn.layer.cornerRadius = 10
        
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
        spinner.backgroundColor = UIColor(white: 0.9, alpha: 0.4)
        spinner.layer.cornerRadius = 3.0
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()

        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.router?.routeToDashboardPage(segue: nil)
        }
    }
    
    func doSomething() {
        let request = Login.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: Login.Something.ViewModel) {
        //nameTextField.text = viewModel.name
        // Test Pull Request
    }
}
