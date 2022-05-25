//
//  CodableLabelStyle.swift
//  LithoUtils
//
//  Created by Remmington Damper on 1/12/22.
//

import Foundation
import UIKit
import Prelude
import LithoOperators

open class CodableLabelStyle: CodableViewStyleProtocol, Codable {
    public var backgroundColorHex: String?
    public var tintColorHex: String?
    public var isHidden: Bool?
    public var isOpaque: Bool?
    public var clipsToBounds: Bool?
    public var alpha: CGFloat?
    public var cornerRadius: CGFloat?
    public var maskedCorners: CACornerMask?
    public var isRounded: Bool?
    public var borderWidth: CGFloat?
    public var borderColorHex: String?
    public var shadowColorHex: String?
    public var shadowRadius: CGFloat?
    public var shadowOpacity: Float?
    public var lineHeightMultiplier: CGFloat?
    
    public var font: CodableFont?
    public var textColor: String?
    public var labelShadowColor: String?
    
    public init() {}
    
    public func apply(to view: UIView?) {
        view |> ~>styleLabelFunction(given: self)
    }
}

public func styleLabelFunction(given style: CodableLabelStyle) -> (UILabel?) -> Void {
    let doNothing: (UILabel) -> Void = styleFunction(given: style)
    var result: (UILabel) -> Void = doNothing

    result <>= style.labelShadowColor |> (~>UIColor.init(hexString:) >>> (\UILabel.shadowColor *-> set))
    result <>= { $0 |> set(\.attributedText, $0.text |> styledAttributedText(given: style)) }
    result <>= style.textColor |> (~>UIColor.init(hexString:) >>> (\UILabel.textColor *-> set))
    result <>= style.font?.setOnLabel
    
    return ~>result
}

public func styledAttributedText(given style: CodableLabelStyle) -> (String?) -> NSAttributedString? {
    return { text in
        var promptAttributes: [NSAttributedString.Key: Any] = [:]
        if let spacing = style.lineHeightMultiplier {
            let paragraph = NSMutableParagraphStyle()
            paragraph.lineHeightMultiple = spacing
            promptAttributes[.paragraphStyle] = paragraph
        }
        if let color = style.textColor {
            promptAttributes[.foregroundColor] = UIColor(hexString: color)
        }
        if let font = style.font {
            promptAttributes[.font] = font.font()
        }
        return NSAttributedString(string: text ?? "", attributes: promptAttributes)
    }
}
