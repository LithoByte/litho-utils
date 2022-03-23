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
    public var isRounded: Bool?
    public var borderWidth: CGFloat?
    public var borderColorHex: String?
    public var shadowColorHex: String?
    public var shadowRadius: CGFloat?
    public var shadowOpacity: Float?
    
    public var font: CodableFont?
    public var textColor: String?
    public var labelShadowColor: String?
    
    public func apply(to view: UIView) {
        view |> ~>styleLabelFunction(given: self)
    }
}

public func styleLabelFunction(given style: CodableLabelStyle) -> (UILabel) -> Void {
    let doNothing: (UILabel) -> Void = styleFunction(given: style)
    var result: (UILabel) -> Void = doNothing

    result <>= style.textColor |> (~>UIColor.init(hexString:) >>> (\UILabel.textColor *-> set))
    result <>= style.labelShadowColor |> (~>UIColor.init(hexString:) >>> (\UILabel.shadowColor *-> set))
    result <>= style.font?.setOnLabel
    
    return result
}

public func attributedTextSetter(given style: CodableLabelStyle) -> (UILabel, String?) -> Void {
    return { label, text in
        
    }
}
