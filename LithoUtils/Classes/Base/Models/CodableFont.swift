//
//  CodableFont.swift
//  LithoUtils
//
//  Created by Remmington Damper on 1/15/22.
//

import Foundation
import Prelude
import LithoOperators

public struct CodableFont: Codable {
    public var name: String?
    public var size: CGFloat?
    public var dynamic = false
    
    public var setOnLabel: ((UILabel?) -> Void)? {
        get { return ~>set(\UILabel.font, font()) }
    }
    public var setOnTextView: ((UITextView?) -> Void)? {
        get { return ~>set(\UITextView.font, font()) }
    }
    public var setOnTextField: ((UITextField?) -> Void)? {
        get { return ~>set(\UITextField.font, font()) }
    }
    public var setOnButton: ((UIButton?) -> Void)? {
        get { return { button in
            if let title = button?.titleLabel?.attributedText {
                let attributed = NSMutableAttributedString(attributedString: title)
                attributed.addAttributes([.font : font()!], range: NSMakeRange(0, attributed.length))
                button?.setAttributedTitle(attributed, for: .normal)
            }
        }}
    }
    public var setOnButtonWithTitle: ((UIButton?, String) -> Void)? {
        get { return { button, title in
            let attributed = NSAttributedString(string: title, attributes: [.font : font()!])
            button?.setAttributedTitle(attributed, for: .normal)
        }}
    }
    
    public init(name: String?, size: CGFloat?, dynamic: Bool = false) {
        self.name = name
        self.size = size
        self.dynamic = dynamic
    }
    
    public func font() -> UIFont? {
        if let fontName = name, let fontSize = size, let font = UIFont(name: fontName, size: fontSize) {
            if dynamic {
                return scaleFont(font)
            } else {
                return font
            }
        }
        return nil
    }
}

public func scaledFont(name: String, size:CGFloat) -> UIFont? {
    if let font = UIFont(name: name, size: size) {
        return scaleFont(font)
    }
    return nil
}

public func scaleFont(_ font: UIFont) -> UIFont {
    let fontAccessType = getFontAccessibilityType(from: font.pointSize)
    let result = UIFontMetrics(forTextStyle: fontAccessType.style).scaledFont(for: font, maximumPointSize: fontAccessType.max)
    return result
}

// We are going to limit the maximum font size using Dynamic fonts so the app is usable
// In order to support the biggest fonts size we will need to do more work
// Currently supporting up to AX1 (Larger Accessibility Type Sizes). See more of this here: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/typography
func getFontAccessibilityType(from size: CGFloat) -> (style: UIFont.TextStyle, max: CGFloat) {
    var result: UIFont.TextStyle
    var maxResult: CGFloat
    switch size {
    case let x where x >= 30:
        result = .largeTitle
        maxResult = 44.0
    case 24...29:
        result = .title1
        maxResult = 38.0
    case 21...23:
        result = .title2
        maxResult = 34.0
    case 19,20:
        result = .title3
        maxResult = 31.0
    case 17,18:
        result = .body
        maxResult = 28.0
    case 16:
        result = .callout
        maxResult = 26.0
    case 15,14:
        result = .subheadline
        maxResult = 25.0
    case 13:
        result = .footnote
        maxResult = 23.0
    case 12:
        result = .caption1
        maxResult = 22.0
    case 11:
        result = .caption2
        maxResult = 21.0
    default:
        result = .body
        maxResult = 28.0
    }
    return (result, maxResult)
}
