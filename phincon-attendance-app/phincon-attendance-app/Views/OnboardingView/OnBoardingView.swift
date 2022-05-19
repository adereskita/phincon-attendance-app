//
//  OnBoardingView.swift
//  phincon-attendance-app
//
//  Created by Ade on 5/19/22.
//

import UIKit

protocol OnboardingButtonDelegate: AnyObject {
    func didTapLoginButton()
    func didTapSkipButton()
    func didTapRegisterButton()
    func didTapPageControl(sender: UIPageControl)
}

class OnBoardingView: UIView {
    
    weak var delegate: OnboardingButtonDelegate!
    
    @IBOutlet var bottomCardView: UIView!
    @IBOutlet var collView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var imgViewOnboard: UIImageView!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var btnSignup: UIButton!
    @IBOutlet var btnSkip: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func Init() {
        let viewFromXib = UINib(nibName: "OnBoardingView", bundle: .main).instantiate(withOwner: self, options: nil).first as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
     
        configUI()
    }
    
    func configUI() {
        collView.register(OnboardingCollectionViewCell.nib(), forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)

        bottomCardView.layer.shadowColor = UIColor.lightGray.cgColor
        bottomCardView.layer.shadowOffset = CGSize.zero
        bottomCardView.layer.shadowOpacity = 0.2
        bottomCardView.layer.shadowRadius = 3.0
        bottomCardView.layer.cornerRadius = 35
        bottomCardView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        btnLogin.layer.cornerRadius = 10
        btnSignup.layer.cornerRadius = 10
        btnSignup.layer.borderColor = UIColor.lightGray.cgColor
        btnSignup.layer.borderWidth = 2
    }
    
    @IBAction func onClickbBtnSkip(_ sender: Any?) {
        delegate.didTapSkipButton()
    }
    
    @IBAction func pageControlSelectionAction(_ sender: UIPageControl) {
        delegate.didTapPageControl(sender: sender)
    }
    
    @IBAction func loginAction(_ sender: Any?) {
        delegate.didTapLoginButton()
    }
     
    @IBAction func signUpAction(_ sender: Any?) {
        delegate.didTapRegisterButton()
    }
}
