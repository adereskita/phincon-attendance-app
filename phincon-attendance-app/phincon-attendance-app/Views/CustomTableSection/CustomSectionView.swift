//
//  CustomSectionView.swift
//  phincon-attendance-app
//
//  Created by Ade on 5/13/22.
//

import UIKit

class CustomSectionView: UIView {
    
    static let identifier = "CustomSectionView"

    @IBOutlet var contentView: UIView!
    @IBOutlet var sectionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initWithNib()
    }
    
    func initWithNib() {
        Bundle.main.loadNibNamed(CustomSectionView.identifier, owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
//        contentView.frame = self.bounds
//        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setupLayout()
    }
    
    
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                contentView.topAnchor.constraint(equalTo: topAnchor),
                contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
                contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
                contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ]
        )
    }

}
