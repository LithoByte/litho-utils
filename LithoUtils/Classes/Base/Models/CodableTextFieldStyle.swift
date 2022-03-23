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
    public var isRounded: Bool?
    public var borderWidth: CGFloat?
    public var borderColorHex: String?
    public var shadowColorHex: String?
    public var shadowRadius: CGFloat?
    public var shadowOpacity: Float?
    
    public var font: CodableFont?
    public var textColor: String?
    public var borderStyle: UITextField.BorderStyle?
    
    public func apply(to view: UIView) {
        view |> ~>styleTextFieldFunction(given: self)
    }
}

extension UITextField.BorderStyle: Codable {}

public func styleTextFieldFunction(given style: CodableTextFieldStyle) -> (UITextField) -> Void {
    var result: (UITextField) -> Void = { _ in }

    result <>= style.font?.setOnTextField
    result <>= style.textColor |> (~>UIColor.init(hexString:) >>> (\UITextField.textColor *-> set))
    result <>= style.borderStyle ?> (\UITextField.borderStyle *-> set)
    
    result <>= styleFunction(given: style)
    
    return result
}
