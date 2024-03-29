//
//  ProfilTableViewCell.swift
//  phincon-attendance-app
//
//  Created by Sri Endah Ramurti on 23/03/22.
//

import UIKit
import SkeletonView

class ProfilTableViewCell: UITableViewCell {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var chevronButton: UIButton!
    
    var label: [String] = []
    var picture: [String] = []
    
    static let identifier = "ProfilTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ProfilTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        label = ["No. Karyawan", "Alamat", "Change Password"]
        picture = ["id_card", "book", "password"]
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setupProfilView(with model: Users){
        chevronButton.isHidden = true
        titleLabel.text = label[0]
        descLabel.text = String(describing: model.idcardnumber!)
        icon.image = UIImage(named: picture[0])!.withRenderingMode(.alwaysTemplate)
        icon.layer.cornerRadius = 8
        
        view1.layer.cornerRadius = 10
        view1.layer.shadowColor = UIColor.lightGray.cgColor
        view1.layer.shadowRadius = 3.0
        view1.layer.shadowOffset = CGSize.zero
        view1.layer.shadowOpacity = 0.2
        
        descLabel.isSkeletonable = true
        
        descLabel.showAnimatedSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.descLabel.hideSkeleton()
        })
    }
    func setupAddress(with model: Users) {
        chevronButton.isHidden = true
        titleLabel.text = label[1]
        descLabel.text = model.address
        icon.image = UIImage(named: picture[1])!.withRenderingMode(.alwaysTemplate)
        icon.layer.cornerRadius = 8
        
        view1.layer.cornerRadius = 10
        view1.layer.shadowColor = UIColor.lightGray.cgColor
        view1.layer.shadowRadius = 3.0
        view1.layer.shadowOffset = CGSize.zero
        view1.layer.shadowOpacity = 0.2
        
        descLabel.isSkeletonable = true
        
        descLabel.showAnimatedSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.descLabel.hideSkeleton()
        })
    }
    func setupPassword(with model: Users) {
        chevronButton.isHidden = false
        titleLabel.text = label[2]
        descLabel.text = "**********"
        icon.image = UIImage(named: picture[2])!.withRenderingMode(.alwaysTemplate)
        icon.layer.cornerRadius = 8
        
        view1.layer.cornerRadius = 10
        view1.layer.shadowColor = UIColor.lightGray.cgColor
        view1.layer.shadowRadius = 3.0
        view1.layer.shadowOffset = CGSize.zero
        view1.layer.shadowOpacity = 0.2
        
        descLabel.isSkeletonable = true
        
        descLabel.showAnimatedSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.descLabel.hideSkeleton()
        })
    }
}
