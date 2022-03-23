//
//  ProfilTableViewCell.swift
//  phincon-attendance-app
//
//  Created by Sri Endah Ramurti on 23/03/22.
//

import UIKit

class ProfilTableViewCell: UITableViewCell {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setup(){
        icon.layer.cornerRadius = 8
        icon.tintColor = UIColor(red: 0, green: 71, blue: 204, alpha: 1)
        icon.backgroundColor = UIColor(red: 223, green: 231, blue: 245, alpha: 1)
        view1.layer.cornerRadius = 10
        view1.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.0523)
        view1.layer.shadowRadius = 3.0
        view1.layer.shadowOffset = CGSize.zero
        view1.layer.shadowOpacity = 0.2
        
    }
    
}
