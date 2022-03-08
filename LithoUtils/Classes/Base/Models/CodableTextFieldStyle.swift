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

open class CodableTextFieldStyle: CodableViewStyle {
    open var font: CodableFont?
    open var textColor: String?
    open var borderStyle: UITextField.BorderStyle?
    
    public init(backgroundColorHex: String? = nil, tintColorHex: String? = nil, isHidden: Bool? = nil, isOpaque: Bool? = nil, clipsToBounds: Bool? = nil, alpha: CGFloat? = nil, cornerRadius: CGFloat? = nil, isRounded: Bool? = nil, borderWidth: CGFloat? = nil, borderColorHex: String? = nil, shadowColorHex: String? = nil, shadowRadius: CGFloat? = nil, shadowOpacity: Float? = nil, font: CodableFont? = nil, textColor: String? = nil, borderStyle: UITextField.BorderStyle? = nil) {
        self.font = font
        self.textColor = textColor
        self.borderStyle = borderStyle
        super.init(backgroundColorHex: backgroundColorHex, tintColorHex: tintColorHex, isHidden: isHidden, isOpaque: isOpaque, clipsToBounds: clipsToBounds, alpha: alpha, cornerRadius: cornerRadius, isRounded: isRounded, borderWidth: borderWidth, borderColorHex: borderColorHex, shadowColorHex: shadowColorHex, shadowRadius: shadowRadius, shadowOpacity: shadowOpacity)
    }
    
    private enum CodingKeys: String, CodingKey {
        case font, textColor, borderStyle
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        textColor = try? container.decode(String.self, forKey: .textColor)
        font = try? container.decode(CodableFont.self, forKey: .font)
        if let intValue = try? container.decode(Int.self, forKey: .borderStyle) {
            borderStyle = UITextField.BorderStyle(rawValue: intValue)
        }
        
        let superDecoder = try container.superDecoder()
        try super.init(from: superDecoder)
    }
    
    public override func apply(to view: UIView) {
        view |> ~>styleTextFieldFunction(given: self)
    }
}

public func styleTextFieldFunction(given style: CodableTextFieldStyle) -> (UITextField) -> Void {
    let doNothing: (UITextField) -> Void = styleFunction(given: style)
    var result: (UITextField) -> Void = doNothing

    result <>= style.font?.setOnTextField
    result <>= style.textColor |> (~>UIColor.init(hexString:) >>> (\UITextField.textColor *-> set))
    result <>= style.borderStyle ?> (\UITextField.borderStyle *-> set)
    return result
}
