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

open class CodableButtonStyle: CodableViewStyle {
    open var buttonTitleColor: String?
    open var buttonTitleShadowColor: String?
    open var buttonTitleAndImageTintColor: String?
    open var buttonFont: CodableFont?
}

public func styleButtonFunction(given style: CodableUIButtonStyle) -> (UIButton) -> Void {
    let doNothing: (UIButton) -> Void = { _ in }
    var result: (UIButton) -> Void = doNothing
    
//    result <>= style.buttonTitleColor |> (~>UIColor.init(hexString:) >>> UIButton.setTitleColor(_:for:))
//    result <>= style.buttonTitleShadowColor |> (~>UIColor.init(hexString:) >>> (\UIButton.setTitleShadowColor() *-> set))
    result <>= style.buttonFont?.setOnButton
    result <>= style.buttonTitleAndImageTintColor |> (~>UIColor.init(hexString:) >>> (\UIButton.tintColor *-> set))
  return result
}
