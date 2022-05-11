//
//  DayFilterTableViewCell.swift
//  phincon-attendance-app
//
//  Created by Ade on 3/14/22.
//

import UIKit

class DayFilterCollViewCell: UICollectionViewCell {
        
    @IBOutlet var cardView: UIView!
    @IBOutlet var filterLbl: UILabel!
    
    static let identifier = "DayFilterCollViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DayFilterCollViewCell", bundle: nil)
    }
    
    override var isSelected: Bool {
        didSet {
            filterLbl.textColor = isSelected ? UIColor(red: 0, green: 0.278, blue: 0.8, alpha: 1) : .systemGray
            cardView.backgroundColor = isSelected ? UIColor(red: 0.875, green: 0.906, blue: 0.961, alpha: 1) : .white
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setView(_ string: String) {
        cardView.layer.cornerRadius = 5
        filterLbl.text = string
    }
    
}
