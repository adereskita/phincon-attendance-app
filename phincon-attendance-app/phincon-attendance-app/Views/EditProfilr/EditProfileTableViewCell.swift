//
//  EditProfileTableViewCell.swift
//  phincon-attendance-app
//
//  Created by Sri Endah Ramurti on 30/03/22.
//

import UIKit

class EditProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var view : UIView!
    @IBOutlet weak var image1 : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var descLabebl : UILabel!
    
    static let identifier = "EditProfileTableViewCell"
    
    
    static func nib() -> UINib {
        return UINib(nibName: "EditProfileTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell (with model: EditProfileData) {
        image1.image = model.iconData
        titleLabel.text = model.titleData
        descLabebl.text = model.descData
        
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 3.0
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowOpacity = 0.5
    }
    
}
