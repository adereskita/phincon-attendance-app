//
//  OnBoardingViewController.swift
//  phincon-attendance-app
//
//  Created by Satriya on 10/03/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

/*
 MARK: This moduls purpose is only for 
 */

import UIKit

class OnBoardingViewController: UIViewController {
        
    @IBOutlet var bottomCardView: UIView!
    @IBOutlet var collView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var imgViewOnboard: UIImageView!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var btnSignup: UIButton!
    @IBOutlet var btnSkip: UIButton!
    
    var onboardSlide: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet {
            if currentPage == 0 {
                imgViewOnboard.setImage(#imageLiteral(resourceName: "onboard-page1"), animated: true)
            } else {
                imgViewOnboard.setImage(onboardSlide[currentPage].image, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // next future move this to json
        onboardSlide = [
            OnboardingSlide(title: "DIGITAL ABSENSI",
                            description: "Kehadiran sistem absensi digital merupakan penemuan yang mampu menggantikan pencatatan data kehadiran secara manual", image: #imageLiteral(resourceName: "onboard-page1")),
            OnboardingSlide(title: "ATTENDANCE SYSTEM", description: "Pengelolaan karyawan di era digital yang baik, menghasilkan karyawan terbaik pula, salah satunya absensi karyawan", image: #imageLiteral(resourceName: "onboard-page2")),
            OnboardingSlide(title: "SELALU PAKAI MASKER", description: "Guna mencegah penyebaran virus Covid-19, Pemerintah telah mengeluarkan kebijakan Physical Distancing serta kebijakan bekerja, belajar, dan beribadah dari rumah.", image: #imageLiteral(resourceName: "onboard-page3"))
        ]
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
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let dashboardVC = storyBoard.instantiateViewController(withIdentifier: "LoginPage")
//        self.definesPresentationContext = true
        dashboardVC.modalPresentationStyle = .fullScreen
        self.present(dashboardVC, animated:true, completion:nil)
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

extension UIImageView{
    func setImage(_ image: UIImage?, animated: Bool = true) {
        let duration = animated ? 0.2 : 0.0
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
            self.image = image
        }, completion: nil)
    }
}
 