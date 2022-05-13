//
//  DashboardTableCell.swift
//  phincon-attendance-app
//
//  Created by Ade on 3/14/22.
//

import UIKit
import SkeletonView

class DashboardTableCell: UITableViewCell {
    
    @IBOutlet var cardView: UIView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var descLbl: UILabel!
    @IBOutlet var ivCell: UIImageView!
    
    static let identifier = "DashboardTableCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DashboardTableCell", bundle: nil)
    }
    
    var selectedColor: UIColor = .gray
    var selectedColorLbl: UIColor = .black
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.selectionStyle = .none
        // Initialization code
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        self.selectedBackgroundView?.backgroundColor = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        cardView.backgroundColor = isSelected ? selectedColor : .white
        titleLbl.textColor = isSelected ? selectedColorLbl : .black
        descLbl.textColor = isSelected ? selectedColorLbl : .black
        self.selectedBackgroundView?.backgroundColor = nil
        
//        cardView.layer.borderWidth = isSelected ? 1 : 0
//        cardView.layer.borderColor = isSelected ? UIColor(red: 0.078, green: 0.173, blue: 0.392, alpha: 1).cgColor : nil
    }
    
    func setupView() {
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOffset = CGSize.zero
        cardView.layer.shadowOpacity = 0.3
        cardView.layer.shadowRadius = 3.0
    }
    
    func setDashboardCellView(_ models: Location) {
        setupView()
        
        titleLbl.text = ""
        descLbl.text = ""
        ivCell.image = nil
        
        titleLbl.isSkeletonable = true
        descLbl.isSkeletonable = true
        ivCell.isSkeletonable = true
        
        ivCell.skeletonCornerRadius = 5
        
        titleLbl.showAnimatedSkeleton()
        descLbl.showAnimatedSkeleton()
        ivCell.showAnimatedSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [self] in
            titleLbl.text = models.name
            ivCell.image = UIImage(named: models.image!)
            descLbl.text = models.address
            
            titleLbl.hideSkeleton()
            descLbl.hideSkeleton()
            ivCell.hideSkeleton()
        })
    }
    
}
