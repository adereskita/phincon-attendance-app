//
//  ProfilePictureTableViewCell.swift
//  phincon-attendance-app
//
//  Created by Sri Endah Ramurti on 30/03/22.
//

import UIKit

class ProfilePictureTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView : UIView!
    @IBOutlet weak var profilePicture : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var roleLabel : UILabel!
    
    static let identifier = "ProfileImageTableViewCell"
    
    
    static func nib() -> UINib {
        return UINib(nibName: "ProfileImageTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupprofileImage(with model : ProfileImage) {
        profilePicture.image = model.image
        nameLabel.text = model.name
        roleLabel.text = model.role
        
        cardView.layer.cornerRadius = 21
        cardView.layer.shadowColor = colorUtils.lightGrey.cgColor
        cardView.layer.shadowRadius = 12
        cardView.layer.shadowOpacity = 0.3
        cardView.layer.shadowOffset = CGSize.zero
    }
    
    
}
