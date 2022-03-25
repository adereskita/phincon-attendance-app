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
    
    override var isSelected: Bool {
        didSet {
            cardView.backgroundColor = isSelected ? .gray : .white
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
//        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setDashboardCellView(_ models: Checkin) {
        self.backgroundColor = nil
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
