//
//  UIColor+Hex.swift
//  LUX
//
//  Created by Elliot Schrock on 12/26/19.
//

import UIKit

extension UIColor {
    public convenience init(hex: UInt32) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        
        self.init(red: red, green: green, blue: blue, alpha:1.0)
    }
    
    public static func uicolorFromHex(rgbValue: UInt32) -> UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red: red, green: green, blue: blue, alpha:1.0)
    }
}
