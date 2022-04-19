//
//  HistoryTableViewCell.swift
//  phincon-attendance-app
//
//  Created by Ade on 3/15/22.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet var cardView: UIView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var descLbl: UILabel!
    @IBOutlet var imgView: UIImageView!
    
    static let identifier = "HistoryTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "HistoryTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectedBackgroundView?.backgroundColor = .clear
        cardView.backgroundColor = isSelected ? .systemGray4 : .white
        // Configure the view for the selected state
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        self.selectedBackgroundView?.backgroundColor = .clear
    }
    
    func setHistoryView(with model: History) {
        titleLbl.text = "Check " + model.activity! + " - " + model.locationName! + " - " + model.createdAt!
        descLbl.text = model.locationAddress
        imgView.image = UIImage(named: model.locationImage!)
        
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOffset = CGSize.zero
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowRadius = 3.0
    }
    
}
