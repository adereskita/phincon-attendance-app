//
//  LoginView.swift
//  phincon-attendance-app
//
//  Created by Ade on 5/10/22.
//

import UIKit

protocol ButtonTapDelegate: AnyObject {
    func didTapLoginButton()
    func didTapBackButton()
    func didTapRegisterButton()
    func didTapForgotPassButton()
}

class LoginView: UIView {
    
    weak var delegate: ButtonTapDelegate!

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var cardView: UIView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var errorLbl: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func Init() {
//        let viewFromXib = Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)?.first as! UIView
        let viewFromXib = UINib(nibName: "LoginView", bundle: .main).instantiate(withOwner: self, options: nil).first as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        
        setupUI()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        delegate.didTapLoginButton()
    }
    
    @IBAction func forgotPassButton(_ sender: Any) {
        delegate.didTapForgotPassButton()
    }
    @IBAction func registerButton(_ sender: Any){
        delegate.didTapRegisterButton()
    }
    
    @IBAction func backButton(_ sender: Any) {
        delegate.didTapBackButton()
    }
    
    func setupUI() {
        errorLbl.isHidden = true
        spinner.isHidden = true
        loginBtn.layer.cornerRadius = 10
        
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOffset = CGSize.zero
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowRadius = 3.0
        cardView.layer.cornerRadius = 25
        cardView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}
