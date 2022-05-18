//
//  DashboardView.swift
//  phincon-attendance-app
//
//  Created by Ade on 5/11/22.
//

import UIKit

class DashboardView: UIView {
        
    @IBOutlet var dashboardTableView: UITableView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var navbarView: UIView!
    @IBOutlet var bgTopView: UIView!
    @IBOutlet var navBarViewTopConstraint: NSLayoutConstraint!

    
    weak var navBar: NavigationBarView!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        Init()
        navBar = navbarView as? NavigationBarView
        navBar.titleLabel.text = "Your Attendance"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func Init() {
        let viewFromXib = UINib(nibName: "DashboardView", bundle: .main).instantiate(withOwner: self, options: nil).first as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
     
        setupUI()
    }
    
    func setupUI() {
//        self.translatesAutoresizingMaskIntoConstraints = true
        bgTopView.backgroundColor = colorUtils.darkBlueHead
        spinner.isHidden = true
        dashboardTableView.register(DashboardTableCell.nib(), forCellReuseIdentifier: DashboardTableCell.identifier)
        dashboardTableView.register(DashboardHeaderCell.nib(), forCellReuseIdentifier: DashboardHeaderCell.identifier)
        
        dashboardTableView.separatorStyle = .none
        dashboardTableView.estimatedRowHeight = 76
    }
    
}
