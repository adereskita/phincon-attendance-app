//
//  ImageUtils.swift
//  phincon-attendance-app
//
//  Created by Ade on 4/6/22.
//

import Foundation
import UIKit


extension UIImageView{
    
    func setImage(_ image: UIImage?, animated: Bool = true) {
        let duration = animated ? 0.2 : 0.0
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
            self.image = image
        }, completion: nil)
    }
}

extension UIImage {
    func addPadding(_ padding: CGFloat) -> UIImage {
        let alignmentInset = UIEdgeInsets(top: -padding, left: -padding,
                                          bottom: -padding, right: -padding)
        return withAlignmentRectInsets(alignmentInset)
    }
}
