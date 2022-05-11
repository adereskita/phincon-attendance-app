//
//  ProfileView.swift
//  phincon-attendance-app
//
//  Created by Ade on 5/11/22.
//

import UIKit

protocol ProfileButtonDelegate: AnyObject {
    func didTapMenu()
}

class ProfileView: UIView {
    
    weak var delegate: ProfileButtonDelegate!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Init()
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
        tableView.register(ProfilTableViewCell.nib(), forCellReuseIdentifier: ProfilTableViewCell.identifier)
        tableView.register(ProfilePictureTableViewCell.nib(), forCellReuseIdentifier: ProfilePictureTableViewCell.identifier)
        tableView.estimatedRowHeight = 72
        tableView.layer.cornerRadius = 18
    }
    
    
    @IBAction func profileMenu(_ sender:Any) {
        delegate.didTapMenu()
    }
}
