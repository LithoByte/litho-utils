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

open class CodableLabelStyle : CodableViewStyle {
    open var font: CodableFont?
    open var textColor: String?
    open var labelShadowColor: String?
}

public func styleLabelFunction(given style: CodableLabelStyle) -> (UILabel) -> Void {
    let doNothing: (UILabel) -> Void = styleFunction(given: style)
    var result: (UILabel) -> Void = doNothing

    result <>= style.textColor |> (~>UIColor.init(hexString:) >>> (\UILabel.textColor *-> set))
    result <>= style.labelShadowColor |> (~>UIColor.init(hexString:) >>> (\UILabel.shadowColor *-> set))
    result <>= style.font?.setOnLabel
    
    return result
}
