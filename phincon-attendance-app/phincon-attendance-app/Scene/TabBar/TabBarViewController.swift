//
//  TabBarViewController.swift
//  phincon-attendance-app
//
//  Created by Ade on 5/11/22.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let homeVC = DashboardViewController()
    let historyVC = HistoryViewController()
    let profileVC = ProfilViewController()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        var tabFrame = self.tabBar.frame
//
//        tabFrame.size.height = 96
//        tabFrame.origin.y = self.view.frame.size.height - 96
//        self.tabBar.frame = tabFrame
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeVC.title = "Home"
        historyVC.title = "History"
        profileVC.title = "Profile"
        
//        let navHomeVC = UINavigationController(rootViewController: homeVC)
//        let navHistoryVC = UINavigationController(rootViewController: homeVC)
//        let navProfileVC = UINavigationController(rootViewController: homeVC)
        
        self.setViewControllers([homeVC, historyVC, profileVC], animated: false)
        setupTabBar()
        
        guard let items = self.tabBar.items else { return }
        
        let images = ["home-logo", "history-inactive", "profile-inactive"]
        
        for x in 0...items.count - 1 {
            items[x].image = UIImage(named: images[x])
        }
    }
    
    func setupTabBar() {
        tabBar.backgroundColor = .white
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        tabBar.layer.shadowRadius = 15
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.masksToBounds = false
        
        tabBar.itemPositioning = .fill
//        tabBar.itemSpacing = UIScreen.main.bounds.width / 6

        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        tabBar.standardAppearance = appearance
        
        self.tabBar.isTranslucent = false
    }
    
}
