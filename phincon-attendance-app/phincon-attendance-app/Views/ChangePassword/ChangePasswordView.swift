//
//  ChangePasswordView.swift
//  phincon-attendance-app
//
//  Created by Sri Endah Ramurti on 20/05/22.
//

import UIKit

protocol ButtonChangeDelegate: AnyObject {
    func didTapSaveButton()
    func didTapBackButton()
}

class ChangePasswordView: UIView {
    
    weak var delegate: ButtonChangeDelegate!
    
    @IBOutlet var cardView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var newPassTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func Init() {
        let viewFromXib = UINib(nibName: "ChangePasswordView", bundle: .main).instantiate(withOwner: self, options: nil).first as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        setupUI()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        delegate.didTapSaveButton()
    }
    @IBAction func backButton(_ sender: Any) {
        delegate.didTapBackButton()
    }
    
    func setupUI() {
        spinner.isHidden = true
        saveButton.layer.cornerRadius = 10
        saveButton.backgroundColor = colorUtils.darkBlueHead
        saveButton.tintColor = UIColor.white
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.textAlignment = .center
        saveButton.layer.cornerRadius = 8
        
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOffset = CGSize.zero
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowRadius = 3.0
        cardView.layer.cornerRadius = 25
        cardView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func setupSpinner(isSuccess: Bool, message: String?) {
        spinner.isHidden = false
        spinner.style = .medium
        spinner.backgroundColor = UIColor(white: 0.9, alpha: 0.6)
        spinner.layer.cornerRadius = 10.0
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()

        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.spinner.isHidden = true
        }
    }
}

