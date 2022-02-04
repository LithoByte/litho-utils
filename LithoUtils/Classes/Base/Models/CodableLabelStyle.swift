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
    open var labelFont: CodableFont?
    open var labelTextColor: String?
    open var labelShadowColor: String?
}

public func styleLabelFunction(given style: CodableUILabelStyle) -> (UILabel) -> Void {
    let doNothing: (UILabel) -> Void = { _ in }
    var result: (UILabel) -> Void = doNothing

    result <>= style.labelTextColor |> (~>UIColor.init(hexString:) >>> (\UILabel.textColor *-> set))
    result <>= style.labelShadowColor |> (~>UIColor.init(hexString:) >>> (\UILabel.shadowColor *-> set))
    result <>= style.labelFont?.setOnLabel
    
    return result
}
