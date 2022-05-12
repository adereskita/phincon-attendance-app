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
    @IBOutlet var errorLabel: UILabel!
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
        errorLabel.isHidden = true
        spinner.isHidden = true
        resetPassButton.layer.cornerRadius = 10
        
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOffset = CGSize.zero
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowRadius = 3.0
        cardView.layer.cornerRadius = 25
        cardView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
