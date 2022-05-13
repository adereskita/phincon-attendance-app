//
//  DashboardHeaderView.swift
//  phincon-attendance-app
//
//  Created by Ade on 5/12/22.
//

import UIKit

protocol DashboardHeaderButtonDelegate: AnyObject {
    func didTapCheck()
}

class DashboardHeaderCell: UITableViewCell {
    
    weak var delegate: DashboardHeaderButtonDelegate!
    
    @IBOutlet var checkInBtn: UIButton!
    @IBOutlet var circleBg: UIImageView!
    @IBOutlet var topCardView: UIView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var bgView: UIView!
    
    var isCheckOut: Bool! {
        didSet {
            if isCheckOut {
                checkInBtn.setTitle("CHECK OUT", for: .normal)
                circleBg.tintColor = colorUtils.yellow
            } else {
                checkInBtn.setTitle("CHECK IN", for: .normal)
                circleBg.tintColor = colorUtils.green
            }
        }
    }
    
    static let identifier = "DashboardHeaderCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DashboardHeaderCell", bundle: nil)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configUI() {
        bgView.backgroundColor = colorUtils.darkBlueHead
        bgView.tintColor = colorUtils.darkBlueHead
        
        checkInBtn.titleLabel?.textAlignment = .center
        checkInBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        checkInBtn.titleLabel?.minimumScaleFactor = 0.5
        
        circleBg.layer.shadowColor = UIColor.lightGray.cgColor
        circleBg.layer.shadowOffset = CGSize.zero
        circleBg.layer.shadowOpacity = 0.4
        circleBg.layer.shadowRadius = 10.0

        topCardView.layer.cornerRadius = 20
        topCardView.layer.shadowColor = UIColor.lightGray.cgColor
        topCardView.layer.shadowOffset = CGSize.zero
        topCardView.layer.shadowOpacity = 0.2
        topCardView.layer.shadowRadius = 3.0
    }
    
    @IBAction func btnCheckPressed(_ sender: Any) {
        delegate.didTapCheck()
    }
}
