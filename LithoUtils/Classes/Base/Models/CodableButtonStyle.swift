//
//  CodableButton.swift
//  LithoUtils
//
//  Created by Remmington Damper on 1/9/22.
//

import Foundation
import LithoOperators
import Prelude
import UIKit
import LithoStrings

open class CodableButtonStyle: CodableViewStyle {
    open var titleColor: String?
    open var titleShadowColor: String?
    open var titleAndImageTintColor: String?
    open var font: CodableFont?
    
    public init(backgroundColorHex: String? = nil, tintColorHex: String? = nil, isHidden: Bool? = nil, isOpaque: Bool? = nil, clipsToBounds: Bool? = nil, alpha: CGFloat? = nil, cornerRadius: CGFloat? = nil, isRounded: Bool? = nil, borderWidth: CGFloat? = nil, borderColorHex: String? = nil, shadowColorHex: String? = nil, shadowRadius: CGFloat? = nil, shadowOpacity: Float? = nil, titleColor: String? = nil, titleShadowColor: String? = nil, titleAndImageTintColor: String? = nil, font: CodableFont? = nil) {
        self.titleColor = titleColor
        self.titleShadowColor = titleShadowColor
        self.titleAndImageTintColor = titleAndImageTintColor
        self.font = font
        super.init(backgroundColorHex: backgroundColorHex, tintColorHex: tintColorHex, isHidden: isHidden, isOpaque: isOpaque, clipsToBounds: clipsToBounds, alpha: alpha, cornerRadius: cornerRadius, isRounded: isRounded, borderWidth: borderWidth, borderColorHex: borderColorHex, shadowColorHex: shadowColorHex, shadowRadius: shadowRadius, shadowOpacity: shadowOpacity)
    }
    
    private enum CodingKeys: String, CodingKey {
        case titleColor, titleShadowColor, titleAndImageColor, font
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        titleColor = try? container.decode(String.self, forKey: .titleColor)
        titleShadowColor = try? container.decode(String.self, forKey: .titleShadowColor)
        titleAndImageTintColor = try? container.decode(String.self, forKey: .titleColor)
        font = try? container.decode(CodableFont.self, forKey: .font)
        let superDecoder = try container.superDecoder()
        try super.init(from: superDecoder)
    }
    
    public override func apply(to view: UIView) {
        view |> ~>styleButtonFunction(given: self)
    }
}

public func styleButtonFunction(given style: CodableButtonStyle) -> (UIButton) -> Void {
    let doNothing: (UIButton) -> Void = styleFunction(given: style)
    var result: (UIButton) -> Void = doNothing
    result <>= style.titleColor |> (~>UIColor.init(hexString:) >?> buttonTitleColorSetter(color:))
    result <>= style.titleShadowColor |> (~>UIColor.init(hexString:) >?> buttonTitleColorSetter(color:))
    result <>= style.font?.setOnButton
    result <>= style.titleAndImageTintColor |> (~>UIColor.init(hexString:) >>> (\UIButton.tintColor *-> set))
  return result
}

public func styleButtonWithTitle(given style: CodableButtonStyle, with title: String?) -> (UIButton) -> Void {
    let doNothing: (UIButton) -> Void = styleFunction(given: style)
    var result: (UIButton) -> Void = doNothing
    result <>= style.titleAndImageTintColor |> (~>UIColor.init(hexString:) >>> (\UIButton.tintColor *-> set))
    result <>= style.titleShadowColor |> (~>UIColor.init(hexString:) >?> buttonTitleColorSetter(color:))
    result <>= (title -*> attributedStringSetter(given: style))
    return result
}

func buttonTitleColorSetter(color: UIColor) -> (UIButton) -> Void {
    return {
        button in
        button.setTitleColor(color, for: .normal)
    }
}
func buttonTitleShadowColorSetter(color: UIColor) -> (UIButton) -> Void {
    return {
        button in
        button.setTitleShadowColor(color, for: .normal)
    }
}

func attributedStringSetter(given style: CodableButtonStyle) -> (UIButton, String?) -> Void {
    return { button, title in
        let attributed = convertToMutableString(fromRegularString: title ?? "")
        style.font?.font() ?> (attributed -*> setFontAttributes)
        style.titleColor ?> (UIColor.init(hexString:) >?> (attributed -*> setForegroundColorAttributes))
        button.setAttributedTitle(attributed, for: .normal)
    }
}
