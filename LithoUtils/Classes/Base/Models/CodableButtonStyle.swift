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
    open var titleColor: String?
    open var titleShadowColor: String?
    open var titleAndImageTintColor: String?
    open var font: CodableFont?
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
