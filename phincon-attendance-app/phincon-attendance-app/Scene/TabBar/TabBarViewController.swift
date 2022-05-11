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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeVC.title = "Dashboard"
        historyVC.title = "History"
        profileVC.title = "Profile"
        
        self.setViewControllers([homeVC, historyVC, profileVC], animated: false)
        
        guard let items = self.tabBar.items else { return }
        
        let images = ["home-logo", "history-active", "profile-inactive"]
        
        for x in 0...items.count - 1 {
            items[x].image = UIImage(named: images[x])
        }
        
    }
    
}
