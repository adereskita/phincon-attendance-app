//
//  HistoryView.swift
//  phincon-attendance-app
//
//  Created by Ade on 5/11/22.
//

import UIKit

protocol HistoryButtonDelegate: AnyObject {
    func didTapNotification()
}

class HistoryView: UIView {
    
    weak var delegate: HistoryButtonDelegate!
    
    @IBOutlet var cardView: UIView!
    @IBOutlet var filterCollView: UICollectionView!
    @IBOutlet var historyTableView: UITableView!
    @IBOutlet var emptyLbl: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        Init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func Init() {
        let viewFromXib = UINib(nibName: "HistoryView", bundle: .main).instantiate(withOwner: self, options: nil).first as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
     
        setupUI()
    }
    
    func setupUI() {
        historyTableView.register(HistoryTableViewCell.nib(), forCellReuseIdentifier: HistoryTableViewCell.identifier)
        historyTableView.estimatedRowHeight = 72
        
        filterCollView.register(DayFilterCollViewCell.nib(), forCellWithReuseIdentifier: DayFilterCollViewCell.identifier)
        
        emptyLbl.isHidden = true
        
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOffset = CGSize.zero
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowRadius = 3.0
        cardView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    @IBAction func btnNotificationClicked(_ sender: Any) {
        delegate.didTapNotification()
    }
}
