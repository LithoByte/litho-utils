//
//  UIColor+Hex.swift
//  LUX
//
//  Created by Elliot Schrock on 12/26/19.
//

import UIKit

extension UIColor {
    public convenience init(hex: UInt32) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/255.0
        let green = CGFloat((hex & 0xFF00) >> 8)/255.0
        let blue = CGFloat(hex & 0xFF)/255.0
        
        self.init(red: red, green: green, blue: blue, alpha:1.0)
    }
    
    public static func uicolorFromHex(rgbValue: UInt32) -> UIColor{
        let red = CGFloat((rgbValue & 0xFF000000) >> 16)/255.0
        let green = CGFloat((rgbValue & 0xFF0000) >> 8)/255.0
        let blue = CGFloat(rgbValue & 0xFF00)/255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha:1.0)
    }
    
    public convenience init(hexString: String) {
        var start: String.Index
        if let poundPosition = hexString.firstIndex(of: "#") {
            start = hexString.index(poundPosition, offsetBy: 1)
        } else {
            start = hexString.startIndex
        }
        let hexColor = String(hexString[start...])
        var rgba: (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 1.0)
        if hexColor.count == 3 {
            rgba = hexThreeToRGB(hexColor)
        } else if hexColor.count == 4 {
            rgba = hexFourToRGB(hexColor)
        } else if hexColor.count == 6 {
            rgba = hexSixToRGB(hexColor)
        } else if hexColor.count == 8 {
            rgba = hexEightToRGB(hexColor)
        }
        self.init(red: rgba.0, green: rgba.1, blue: rgba.2, alpha: rgba.3)
    }
}

public func hexThreeToRGB(_ hexString: String) -> (CGFloat, CGFloat, CGFloat, CGFloat) {
    var hexNumber: UInt64 = 0
    let scanner = Scanner(string: hexString)
    scanner.scanHexInt64(&hexNumber)
    let redInt = (hexNumber & 0xF00)
    let redFloat = CGFloat((redInt | (redInt >> 4)) >> 4) / 255
    let greenInt = (hexNumber & 0xF0)
    let greenFloat = CGFloat((greenInt | (greenInt >> 4))) / 255
    let blueInt = (hexNumber & 0xF)
    let blueFloat = CGFloat((blueInt << 4 | (blueInt))) / 255
    return (redFloat, greenFloat, blueFloat, 1.0)
}

public func hexSixToRGB(_ hexString: String) -> (CGFloat, CGFloat, CGFloat, CGFloat) {
    var hexNumber: UInt64 = 0
    let scanner = Scanner(string: hexString)
    scanner.scanHexInt64(&hexNumber)
    let red = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
    let green = CGFloat((hexNumber & 0xFF00) >> 8) / 255.0
    let blue = CGFloat((hexNumber & 0xFF)) / 255.0
    return (red, green, blue, 1.0)
}

public func hexFourToRGB(_ hexString: String) -> (CGFloat, CGFloat, CGFloat, CGFloat) {
    var hexNumber: UInt64 = 0
    let scanner = Scanner(string: hexString)
    scanner.scanHexInt64(&hexNumber)
    let redInt = (hexNumber & 0xF000)
    let redFloat = CGFloat((redInt | (redInt >> 4)) >> 8) / 255
    let greenInt = (hexNumber & 0xF00)
    let greenFloat = CGFloat((greenInt | (greenInt >> 4) >> 4)) / 255
    let blueInt = (hexNumber & 0xF0)
    let blueFloat = CGFloat(blueInt | (blueInt >> 4)) / 255
    let alphaInt = (hexNumber & 0xF)
    let alphaFloat = CGFloat((alphaInt << 4) | alphaInt) / 255
    return (redFloat, greenFloat, blueFloat, alphaFloat)
}

public func hexEightToRGB(_ hexString: String) -> (CGFloat, CGFloat, CGFloat, CGFloat) {
    var hexNumber: UInt64 = 0
    let scanner = Scanner(string: hexString)
    scanner.scanHexInt64(&hexNumber)
    let red = CGFloat((hexNumber & 0xFF000000) >> 24) / 255
    let green = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
    let blue = CGFloat((hexNumber & 0xFF00) >> 8) / 255
    let alpha = CGFloat((hexNumber & 0xFF)) / 255
    return (red, green, blue, alpha)
}
