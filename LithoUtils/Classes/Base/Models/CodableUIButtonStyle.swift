//
//  CodableUIButton.swift
//  LithoUtils
//
//  Created by Remmington Damper on 1/9/22.
//

import Foundation
import LithoOperators
import Prelude
import UIKit

open class CodableUIButtonStyle: CodableViewStyle {
    open var buttonTitleColor: String?
    open var buttonTitleShadowColor: String?
    open var buttonTitleAndImageTintColor: String?
}

public func styleButtonFunction(given style: CodableUIButtonStyle) -> (UIButton) -> Void {
    let doNothing: (UIButton) -> Void = { _ in }
    var result: (UIButton) -> Void = doNothing
    
    result <>= style.buttonTitleColor |> (~> UIColor.init(hexString:) >>> UIButton.setTitleColor(_:for:) *-> set)
    result <>= style.buttonTitleShadowColor |> (~> UIColor.init(hexString:) >>> UIButton.setTitleShadowColor() *-> set)

    //figure out how to set the tint color
  return result
}
