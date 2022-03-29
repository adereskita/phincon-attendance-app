//
//  ColorUtils.swift
//  phincon-attendance-app
//
//  Created by Sri Endah Ramurti on 29/03/22.
//

import Foundation
import UIKit

let colorUtils = ColorUtils()
class ColorUtils : NSObject {
    fileprivate override init() {
            super.init()
    }
    @objc class func sharedInstance() -> ColorUtils {
            return colorUtils
        }
    let darkBlue = UIColor(hex: "#0047CC")
    let green = UIColor(hex: "#11C04D")
    let yellow = UIColor(hex: "#F7B500")
    let lightGrey = UIColor(hex: "#DFE7F5")
}

extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        
        let hexString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).lowercased()
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
        
    }
    
    func toHexString() -> String {
        
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
        
    }
    
}

