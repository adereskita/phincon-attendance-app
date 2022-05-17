//
//  NavigationBarView.swift
//  phincon-attendance-app
//
//  Created by Ade on 5/12/22.
//

import UIKit

protocol NavBarButtonDelegate: AnyObject {
    func didTapNotif()
}

class NavigationBarView: UIView {
    
    weak var delegate: NavBarButtonDelegate!
    
    static let identifier = "NavigationBarView"
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    var navBarViewTopConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initWithNib()
    }
    
    private func initWithNib() {
        Bundle.main.loadNibNamed(NavigationBarView.identifier, owner: self, options: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        setupLayout()
    }
    
    private func setupLayout() {
        navBarViewTopConstraint = view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        
        NSLayoutConstraint.activate(
            [
//                view.topAnchor.constraint(equalTo: topAnchor),
                navBarViewTopConstraint!,
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.bottomAnchor.constraint(equalTo: bottomAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor),
            ]
        )
    }
    
    @IBAction func btnNotificationClicked(_ sender: Any) {
        delegate?.didTapNotif()
    }
}
