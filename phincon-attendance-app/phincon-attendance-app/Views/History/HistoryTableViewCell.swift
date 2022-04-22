//
//  HistoryTableViewCell.swift
//  phincon-attendance-app
//
//  Created by Ade on 3/15/22.
//

import UIKit
import SkeletonView

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
        descLbl.text = model.locationAddress
        imgView.image = UIImage(named: model.locationImage!)
        
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOffset = CGSize.zero
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowRadius = 3.0
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        let dates = df.date(from: model.createdAt!)!
        df.dateFormat = "h:mm a 'on' MMMM dd, yyyy"
        df.amSymbol = "AM"
        df.pmSymbol = "PM"
        let date = df.string(from: dates)
        
        titleLbl.text = "Check " + model.activity!.capitalized + " - " + model.locationName! + " - " + date
        
        titleLbl.isSkeletonable = true
        descLbl.isSkeletonable = true
        imgView.isSkeletonable = true
        
        imgView.skeletonCornerRadius = 5

        titleLbl.showAnimatedSkeleton()
        descLbl.showAnimatedSkeleton()
        imgView.showAnimatedSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.titleLbl.hideSkeleton()
            self.descLbl.hideSkeleton()
            self.imgView.hideSkeleton()
        })
    }
    
}
