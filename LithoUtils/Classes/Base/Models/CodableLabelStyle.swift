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
    
    public var font: CodableFont?
    public var textColor: String?
    public var labelShadowColor: String?
    public var lineHeightMultiplier: CGFloat?
    
    public init(
        backgroundColorHex: String? = nil,
        tintColorHex: String? = nil,
        isHidden: Bool? = nil,
        isOpaque: Bool? = nil,
        clipsToBounds: Bool? = nil,
        alpha: CGFloat? = nil,
        cornerRadius: CGFloat? = nil,
        maskedCorners: CACornerMask? = nil,
        isRounded: Bool? = nil,
        borderWidth: CGFloat? = nil,
        borderColorHex: String? = nil,
        shadowColorHex: String? = nil,
        shadowRadius: CGFloat? = nil,
        shadowOpacity: Float? = nil,
        font: CodableFont? = nil,
        textColor: String? = nil,
        lineHeightMultiplier: CGFloat? = nil,
        labelShadowColor: String? = nil
    ) {
        self.backgroundColorHex = backgroundColorHex
        self.tintColorHex = tintColorHex
        self.isHidden = isHidden
        self.isOpaque = isOpaque
        self.clipsToBounds = clipsToBounds
        self.alpha = alpha
        self.cornerRadius = cornerRadius
        self.maskedCorners = maskedCorners
        self.isRounded = isRounded
        self.borderWidth = borderWidth
        self.borderColorHex = borderColorHex
        self.shadowColorHex = shadowColorHex
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
        self.font = font
        self.textColor = textColor
        self.labelShadowColor = labelShadowColor
        self.lineHeightMultiplier = lineHeightMultiplier
    }
    
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
