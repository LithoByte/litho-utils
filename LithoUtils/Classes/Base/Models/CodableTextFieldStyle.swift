//
//  CodableTextFieldStyle.swift
//  LithoUtils
//
//  Created by Remmington Damper on 1/12/22.
//

import Foundation
import Prelude
import LithoOperators
import UIKit

open class CodableTextFieldStyle: CodableViewStyleProtocol, Codable {
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
    public var borderStyle: UITextField.BorderStyle?
    
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
        borderStyle: UITextField.BorderStyle? = nil
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
        self.borderStyle = borderStyle
    }
    
    public func apply(to view: UIView?) {
        view |> ~>styleTextFieldFunction(given: self)
    }
}

extension UITextField.BorderStyle: Codable {}

public func styleTextFieldFunction(given style: CodableTextFieldStyle) -> (UITextField?) -> Void {
    var result: (UITextField) -> Void = { _ in }

    result <>= style.font?.setOnTextField
    result <>= style.textColor |> (~>UIColor.init(hexString:) >>> (\UITextField.textColor *-> set))
    result <>= style.borderStyle ?> (\UITextField.borderStyle *-> set)
    
    result <>= styleFunction(given: style)
    
    return ~>result
}
