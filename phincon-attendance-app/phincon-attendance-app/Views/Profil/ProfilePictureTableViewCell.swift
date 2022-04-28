//
//  ProfilePictureTableViewCell.swift
//  phincon-attendance-app
//
//  Created by Sri Endah Ramurti on 30/03/22.
//

import UIKit
import SkeletonView

class ProfilePictureTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView : UIView!
    @IBOutlet weak var profilePicture : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var roleLabel : UILabel!
    
    static let identifier = "ProfilePictureTableViewCell"
    
    
    static func nib() -> UINib {
        return UINib(nibName: "ProfilePictureTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupprofileImage(with model : Users) {
        nameLabel.text = model.fullname
        roleLabel.text = model.username
        
        cardView.layer.cornerRadius = 21
        cardView.layer.shadowColor = colorUtils.lightGrey.cgColor
        cardView.layer.shadowRadius = 12
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.shadowOffset = CGSize.zero
        
        nameLabel.isSkeletonable = true
        profilePicture.isSkeletonable = true
        roleLabel.isSkeletonable = true

        nameLabel.showAnimatedSkeleton()
        profilePicture.showAnimatedSkeleton()
        roleLabel.showAnimatedSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.profilePicture.image = UIImage(named: model.image!)
            self.nameLabel.hideSkeleton()
            self.roleLabel.hideSkeleton()
            self.profilePicture.hideSkeleton()
        })
    }
}
