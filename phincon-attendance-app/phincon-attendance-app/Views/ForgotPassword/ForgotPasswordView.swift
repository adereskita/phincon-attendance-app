//
//  ForgotPasswordView.swift
//  phincon-attendance-app
//
//  Created by Sri Endah Ramurti on 13/05/22.
//

import UIKit

protocol ButtonTappedPassDelegate: AnyObject {
    func didTappedResetPassButton(forgotPasswordView: ForgotPasswordView)
    func didTappedLoginButton()
}

class ForgotPasswordView: UIView {
    
    weak var delegate: ButtonTappedPassDelegate!
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pass1TextField: UITextField!
    @IBOutlet weak var pass2TextField: UITextField!
    @IBOutlet var resetPassButton: UIButton!
    @IBOutlet var cardView: UIView!
    @IBOutlet var spinner: UIActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        registerXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func registerXib() {
        let viewFromXib = UINib(nibName: "ForgotPasswordView", bundle: .main).instantiate(withOwner: self, options: nil).first as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        
        setupUI()
    }
    
    func setupUI() {
        spinner.isHidden = true
        resetPassButton.layer.cornerRadius = 10
        
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOffset = CGSize.zero
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowRadius = 3.0
        cardView.layer.cornerRadius = 25
        cardView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    @IBAction func resetPassButton(_ sender: Any) {
        delegate.didTappedResetPassButton(forgotPasswordView: self)
    }
    @IBAction func loginButton(_ sender: Any) {
        delegate.didTappedLoginButton()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func spinnerSetup(isLogin: Bool, message: String?, router: ForgotPasswordRouter) {
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
                    print("Error : \(message)")
                }
            }
        }
    }

}
