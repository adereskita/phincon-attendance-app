//
//  OnBoardingViewController.swift
//  phincon-attendance-app
//
//  Created by Ade on 3/24/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Kingfisher

protocol OnBoardingDisplayLogic: AnyObject {
    func presenter(displayOnboard response: OnBoardingModels.FetchOnBoarding.Response)
}

class OnBoardingViewController: UIViewController, OnBoardingDisplayLogic {
    
    var interactor: OnBoardingBusinessLogic?
    var router: (NSObjectProtocol & OnBoardingRoutingLogic & OnBoardingDataPassing)?

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
        let interactor = OnBoardingInteractor()
        let presenter = OnBoardingPresenter()
        let router = OnBoardingRouter()
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
            if scene == "RegisterSegue" {
                router?.perform(selector)
            }
        }
    }
  
  // MARK: View lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setOnboarding()
    }
  
  // MARK: Do something
    
    var onboardSlide: [Onboarding] = [Onboarding]() {
        didSet{
            self.collView.reloadData()
        }
    }
    
    var currentPage = 0 {
        didSet {
            let modifier = AnyModifier { request in
                var r = request
                r.setValue(ConstantAPI.Server.apiKey, forHTTPHeaderField: ConstantAPI.HttpHeaderField.apikey.rawValue)
                return r
            }
            if currentPage == 0 {
                let imgUrl = URL(string: "http://167.172.74.133:5000/images/onboarding/1650857372580.png")
                imgViewOnboard.kf.setImage(with: imgUrl, placeholder: nil, options: [.requestModifier(modifier)], completionHandler: nil)
                imgViewOnboard.setImage(imgViewOnboard.image, animated: true)
            } else {
                let imgUrl = URL(string: "http://167.172.74.133:5000/images/onboarding/\(onboardSlide[currentPage].image!)")
                self.imgViewOnboard.kf.setImage(with: imgUrl, placeholder: nil, options: [.requestModifier(modifier)], completionHandler: nil)
                imgViewOnboard.setImage(imgViewOnboard.image, animated: true)
            }
        }
    }
  
    @IBOutlet var bottomCardView: UIView!
    @IBOutlet var collView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var imgViewOnboard: UIImageView!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var btnSignup: UIButton!
    @IBOutlet var btnSkip: UIButton!
    
//    var imgID: String?
    let userDefault = UserDefaults.standard
    
    func setOnboarding() {
        let request = OnBoardingModels.FetchOnBoarding.Request()
        interactor?.loadOnboard(request: request)
        SetupUI()
    }
    
    func SetupUI() {
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
        
        self.collView.register(OnboardingCollectionViewCell.nib(), forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        collView.delegate = self
        collView.dataSource = self
        currentPage = 0
    }
    
    func presenter(displayOnboard response: OnBoardingModels.FetchOnBoarding.Response) {
        if let onboard = response.success.result {
            onboardSlide.append(contentsOf: onboard)
        }
    }
    
    @IBAction func onClickbBtnSkip(_ sender: Any?) {
        currentPage = 2
        pageControl.currentPage = currentPage
        var frame: CGRect = self.collView.frame
        frame.origin.x = frame.size.width * CGFloat(currentPage ?? 0)
        frame.origin.y = 0
        self.collView.scrollRectToVisible(frame, animated: true)
    }
    
    @IBAction func pageControlSelectionAction(_ sender: UIPageControl) {
        let page: Int? = sender.currentPage
        var frame: CGRect = self.collView.frame
        frame.origin.x = frame.size.width * CGFloat(page ?? 0)
        frame.origin.y = 0
        currentPage = page!
        self.collView.scrollRectToVisible(frame, animated: true)
    }
    
    @IBAction func loginAction(_ sender: Any?) {
        userDefault.setValue(true, forKey: "isLogin")
        router?.routeToLogin(segue: nil)
    }
     
    @IBAction func signUpAction(_ sender: Any?) {
        userDefault.setValue(false, forKey: "isLogin")
        router?.routeToSignUp(segue: nil)
    }
}

extension OnBoardingViewController: UIGestureRecognizerDelegate {
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
//            navigationController?.popViewController(animated: true)
//        }
//        return false
//    }
    // MARK: Without this code below, the interactive swipe popVC still works
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


extension OnBoardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardSlide.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        let slideObj = onboardSlide[indexPath.row]
        cell.setupView(slideObj)
        return cell
    }
    
    //MARK:- FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.frame.size.width
        let screenHeight = collectionView.frame.size.height
        return CGSize(width: screenWidth, height: screenHeight)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
        
        pageControl.currentPage = currentPage
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
 
