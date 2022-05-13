//
//  DashboardView.swift
//  phincon-attendance-app
//
//  Created by Ade on 5/11/22.
//

import UIKit

class DashboardView: UIView {
        
    @IBOutlet var dashboardTableView: UITableView!
    @IBOutlet var checkInBtn: UIButton!
    @IBOutlet var circleBg: UIImageView!
    @IBOutlet var topCardView: UIView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var navbarView: UIView!
    @IBOutlet var bgTopView: UIView!
    
    weak var navBar: NavigationBarView!
    
    //can register tableview programmatically like this
    private let tableviews: UITableView = {
        let table = UITableView()
        
        table.register(DashboardTableCell.nib(), forCellReuseIdentifier: DashboardTableCell.identifier)
        table.register(DashboardHeaderCell.nib(), forCellReuseIdentifier: DashboardHeaderCell.identifier)
        
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Init()
        navBar = navbarView as? NavigationBarView
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
        bgTopView.backgroundColor = colorUtils.darkBlueHead
        spinner.isHidden = true
        dashboardTableView.register(DashboardTableCell.nib(), forCellReuseIdentifier: DashboardTableCell.identifier)
        dashboardTableView.register(DashboardHeaderCell.nib(), forCellReuseIdentifier: DashboardHeaderCell.identifier)
        
        dashboardTableView.separatorStyle = .none
        dashboardTableView.estimatedRowHeight = 76
    }
    
}
