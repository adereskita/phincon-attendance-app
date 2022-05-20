//
//  EditProfileView.swift
//  phincon-attendance-app
//
//  Created by Sri Endah Ramurti on 19/05/22.
//

import UIKit

protocol ButtonTapedDelegate: AnyObject {
    func didTappedSaveButton()
    func didTappedBackButton()
}

class EditProfileView: UIView {
    
    weak var delegate: ButtonTapedDelegate!
    
    @IBOutlet var cardView : UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Initial()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func Initial() {
        let viewFromXib = UINib(nibName: "EditProfileView", bundle: .main).instantiate(withOwner: self, options: nil).first as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        setupUI()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        delegate.didTappedSaveButton()
    }
    @IBAction func backButton(_ sender: Any) {
        delegate.didTappedBackButton()
    }
    
    func setupUI() {
        spinner.isHidden = true
        
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOffset = CGSize.zero
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowRadius = 3.0
        cardView.layer.cornerRadius = 25
        cardView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        saveButton.backgroundColor = colorUtils.darkBlueHead
        saveButton.tintColor = UIColor.white
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.textAlignment = .center
        saveButton.layer.cornerRadius = 10
        
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
