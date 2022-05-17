//
//  ProfileView.swift
//  phincon-attendance-app
//
//  Created by Ade on 5/11/22.
//

import UIKit

class ProfileView: UIView {
    
    weak var navBar: NavigationBarView!
    
    @IBOutlet var navbarView: UIView!
    @IBOutlet var bgTopView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Init()
        navBar = navbarView as? NavigationBarView
        navBar.titleLabel.text = "Profile"
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .medium)
        let largboldBtn = UIImage(systemName: "line.3.horizontal", withConfiguration: largeConfig)
        navBar.rightButton.setImage(largboldBtn, for: .normal)

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func Init() {
        let viewFromXib = UINib(nibName: "ProfileView", bundle: .main).instantiate(withOwner: self, options: nil).first as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
     
        setupUI()
    }
    
    func setupUI(){
        bgTopView.backgroundColor = colorUtils.darkBlueHead
        tableView.register(ProfilTableViewCell.nib(), forCellReuseIdentifier: ProfilTableViewCell.identifier)
        tableView.register(ProfilePictureTableViewCell.nib(), forCellReuseIdentifier: ProfilePictureTableViewCell.identifier)
        tableView.estimatedRowHeight = 72
        tableView.layer.cornerRadius = 18
    }
}
