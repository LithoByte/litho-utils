//
//  CodableViewStyle.swift
//  LithoUtils
//
//  Created by Elliot on 12/29/21.
//

import UIKit
import Prelude
import LithoOperators

open class CodableViewStyle: Codable {
    open var backgroundColorHex: String?
    open var tintColorHex: String?
    
    open var isHidden: Bool?
    open var isOpaque: Bool?
    open var clipsToBounds: Bool?
    
    open var alpha: CGFloat?
    
    open var cornerRadius: CGFloat?
    
    open var borderWidth: CGFloat?
    open var borderColorHex: String?
    
    open var shadowColorHex: String?
    open var shadowRadius: CGFloat?
    open var shadowOpacity: Float?
    
    public init(backgroundColorHex: String? = nil, tintColorHex: String? = nil, isHidden: Bool? = nil, isOpaque: Bool? = nil, clipsToBounds: Bool? = nil, alpha: CGFloat? = nil, cornerRadius: CGFloat? = nil, borderWidth: CGFloat? = nil, borderColorHex: String? = nil, shadowColorHex: String? = nil, shadowRadius: CGFloat? = nil, shadowOpacity: Float? = nil) {
        self.backgroundColorHex = backgroundColorHex
        self.tintColorHex = tintColorHex
        self.isHidden = isHidden
        self.isOpaque = isOpaque
        self.clipsToBounds = clipsToBounds
        self.alpha = alpha
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.borderColorHex = borderColorHex
        self.shadowColorHex = shadowColorHex
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
    }
}

public func styleFunction(given style: CodableViewStyle) -> (UIView) -> Void {
    let doNothing: (UIView) -> Void = { _ in }
    var result: (UIView) -> Void = doNothing
    result <>= style.backgroundColorHex |> (~>UIColor.init(hexString:) >>> (\UIView.backgroundColor *-> set))
    result <>= style.tintColorHex |> (~>UIColor.init(hexString:) >>> (\UIView.tintColor *-> set))
    
    result <>= style.isHidden ?> (\UIView.isHidden *-> set)
    result <>= style.isOpaque ?> (\UIView.isOpaque *-> set)
    result <>= style.clipsToBounds ?> (\UIView.clipsToBounds *-> set)
    
    result <>= (style.alpha ?> (\UIView.alpha *-> set))
    
    result <>= style.cornerRadius ?> (\UIView.layer.cornerRadius *-> set)
    
    result <>= style.borderColorHex |> (~>UIColor.init(hexString:) >?> ^\UIColor.cgColor >>> (\UIView.layer.borderColor *-> set))
    result <>= style.borderWidth ?> (\UIView.layer.borderWidth *-> set)
    
    result <>= style.shadowColorHex |> (~>UIColor.init(hexString:) >?> ^\UIColor.cgColor >>> (\UIView.layer.shadowColor *-> set))
    result <>= style.shadowRadius ?> (\UIView.layer.shadowRadius *-> set)
    result <>= style.shadowOpacity ?> (\UIView.layer.shadowOpacity *-> set)
    return result
}
