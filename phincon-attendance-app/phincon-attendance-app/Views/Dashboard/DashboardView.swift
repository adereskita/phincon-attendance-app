//
//  DashboardView.swift
//  phincon-attendance-app
//
//  Created by Ade on 5/11/22.
//

import UIKit

protocol DashboardButtonDelegate: AnyObject {
    func didTapNotification()
    func didTapCheck()
}

class DashboardView: UIView {
    
    weak var delegate: DashboardButtonDelegate!
    
    @IBOutlet var dashboardTableView: UITableView!
    @IBOutlet var checkInBtn: UIButton!
    @IBOutlet var circleBg: UIImageView!
    @IBOutlet var topCardView: UIView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var notificationBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Init()
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
        spinner.isHidden = true
        dashboardTableView.register(DashboardTableCell.nib(), forCellReuseIdentifier: DashboardTableCell.identifier)
        dashboardTableView.separatorStyle = .none
        dashboardTableView.estimatedRowHeight = 76
        
        checkInBtn.titleLabel?.textAlignment = .center
        checkInBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        checkInBtn.titleLabel?.minimumScaleFactor = 0.5
        
        circleBg.layer.shadowColor = UIColor.lightGray.cgColor
        circleBg.layer.shadowOffset = CGSize.zero
        circleBg.layer.shadowOpacity = 0.4
        circleBg.layer.shadowRadius = 10.0

        topCardView.layer.cornerRadius = 20
        topCardView.layer.shadowColor = UIColor.lightGray.cgColor
        topCardView.layer.shadowOffset = CGSize.zero
        topCardView.layer.shadowOpacity = 0.2
        topCardView.layer.shadowRadius = 3.0
    }

    @IBAction func btnNotificationClicked(_ sender: Any) {
        delegate.didTapNotification()
    }
    
    @IBAction func btnCheckPressed(_ sender: Any) {
        delegate.didTapCheck()
    }
    
}
