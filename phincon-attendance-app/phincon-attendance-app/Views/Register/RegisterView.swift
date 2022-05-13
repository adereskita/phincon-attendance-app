//
//  RegisterView.swift
//  phincon-attendance-app
//
//  Created by Sri Endah Ramurti on 12/05/22.
//

import UIKit

protocol ButtonTappedDelegate: AnyObject {
    func didTappedRegisterButton(registerView: RegisterView)
    func didTappedLoginButton()
}

class RegisterView: UIView {

    weak var delegate: ButtonTappedDelegate!
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet var cardView : UIView!
    @IBOutlet weak var usernameTextField : UITextField!
    @IBOutlet weak var idTextField : UITextField!
    @IBOutlet weak var FullnameTextField : UITextField!
    @IBOutlet weak var pass1TextField : UITextField!
    @IBOutlet weak var pass2TextField : UITextField!
    @IBOutlet var registerButton : UIButton!
    @IBOutlet var spinner : UIActivityIndicatorView!
    @IBOutlet var errorLbl :UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Init()
       
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func Init() {
        let viewFromXib = UINib(nibName: "RegisterView", bundle: .main).instantiate(withOwner: self, options: nil).first as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        print("loaded")
        
        setupUI()
    }
    
    @IBAction func registerButton(_ sender: Any) {
        delegate.didTappedRegisterButton(registerView: self)
    }
    
    @IBAction func loginButton(_sender: Any) {
        delegate.didTappedLoginButton()
    }
    
    func setupUI() {
        errorLbl.isHidden = true
        spinner.isHidden = true
        registerButton.layer.cornerRadius = 10
        
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOffset = CGSize.zero
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowRadius = 3.0
        cardView.layer.cornerRadius = 25
        cardView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func setupSpinner(isLogin: Bool, message: String?, router: RegisterRouter) {
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
                    if isLogin == true {
                        router.routeToLogin(segue: nil)
                    } else {
                        self.errorLbl.isHidden = false
                        self.errorLbl.text = message?.replacingOccurrences(of: "\"", with: "")
                    }
                
            }
        }
    }
}
