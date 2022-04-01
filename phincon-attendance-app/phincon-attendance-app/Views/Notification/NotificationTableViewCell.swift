//
//  NotificationTableViewCell.swift
//  phincon-attendance-app
//
//  Created by Ade on 3/29/22.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var descLbl: UILabel!
    @IBOutlet var dateLbl: UILabel!
    
    static let identifier = "NotificationTableViewCell"
    
    static func Nib() -> UINib {
        return UINib(nibName: "NotificationTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    func setupCell(with viewModel: Notification) {
        titleLbl.text = viewModel.title
        descLbl.text = viewModel.description
        
        let df = DateFormatter()
        df.dateFormat = "dd-MMM-yyyy"
        let dates = df.date(from: viewModel.date!)
        df.dateFormat = "dd MMMM yyyy"
        df.locale = Locale(identifier: "ID")
        let resDate = df.string(from: dates!)
        
        dateLbl.text = resDate        
    }
}
