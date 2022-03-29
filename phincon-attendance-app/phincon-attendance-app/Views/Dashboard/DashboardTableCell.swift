//
//  DashboardTableCell.swift
//  phincon-attendance-app
//
//  Created by Ade on 3/14/22.
//

import UIKit

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
    
    func setDashboardCellView(_ models: Checkin) {
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOffset = CGSize.zero
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowRadius = 3.0
        
        titleLbl.text = models.title
        descLbl.text = models.description
        ivCell.image = models.image
        
    }
    
}
