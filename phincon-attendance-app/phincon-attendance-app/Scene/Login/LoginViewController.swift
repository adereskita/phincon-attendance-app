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
    func presenter(displayLoginSuccess viewModel: LoginModels.Post.ViewModel)
    func presenter(didFailLogin message: String)
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
    
    override func viewWillAppear(_ animated: Bool) {
        errorLbl.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Do something
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var cardView: UIView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var errorLbl: UILabel!
    
//     @IBAction func dismissButton(_ sender: Any) {
//         dismiss(animated: true)
//         self.navigationController?.popViewController(animated: true)
//     }
  
    @IBAction func loginButton(_ sender: Any) {
        let request = LoginModels.Post.Request(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
        interactor?.login(request)
    }
    @IBAction func forgotPassButton(_sender: Any) {
        router?.routeToForgotPassword(segue: nil)
    }
    @IBAction func registerButton(_sender: Any){
        router?.routeToRegister(segue: nil)
    }
    
    func setupUI() {
        spinner.isHidden = true
        loginBtn.layer.cornerRadius = 10
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
         //Add this tap gesture recognizer to the parent view
         view.addGestureRecognizer(tap)
        
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOffset = CGSize.zero
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowRadius = 3.0
        cardView.layer.cornerRadius = 25
        cardView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func spinnerSetup(isLogin: Bool, message: String?) {
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
                    if isLogin == true {
                        route.routeToDashboardPage(segue: nil)
                    } else {
                        self.errorLbl.isHidden = false
                        self.errorLbl.text = message?.replacingOccurrences(of: "\"", with: "")
//                        self.alertSetup(error: message)
                    }
                }
            }
        }
    }
    
    @objc func dismissMyKeyboard() {
        view.endEditing(true)
    }
    
    func alertSetup(error message: String?) {
        let alert = UIAlertController(title: "Error Occured", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func presenter(displayLoginSuccess viewModel: LoginModels.Post.ViewModel) {
        //nameTextField.text = viewModel.name
        if viewModel.token != nil {
            spinnerSetup(isLogin: true, message: nil)
        }
    }
    
    func presenter(didFailLogin message: String) {
        spinnerSetup(isLogin: false, message: message)
    }
}
