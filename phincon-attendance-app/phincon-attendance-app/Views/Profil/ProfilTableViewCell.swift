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
    
    static let identifier = "ProfilTableViewCell"
    
    
    static func nib() -> UINib {
        return UINib(nibName: "ProfilTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setupProfilView(with model: Profile){
        titleLabel.text = model.titleData
        descLabel.text = model.descData
        icon.image = model.iconData
        icon.layer.cornerRadius = 8
        
        view1.layer.cornerRadius = 10
        view1.layer.shadowColor = UIColor.lightGray.cgColor
        view1.layer.shadowRadius = 3.0
        view1.layer.shadowOffset = CGSize.zero
        view1.layer.shadowOpacity = 0.2
        
    }
    
}
