//
//  NSAttributedStringHelper.swift
//  LithoStrings
//
//  Created by Remmington Damper on 1/24/22.
//

import Foundation
import UIKit

    
public func characterContents(attributedString: NSAttributedString) -> String {
    return attributedString.string
}
public func stringLength(attributedStringLength: NSAttributedString) -> Int {
    return attributedStringLength.length
}
public func convertToMutableString(fromRegularString string: String) -> NSMutableAttributedString {
    return NSMutableAttributedString(string: string)
}
public func convertToMutableString(fromAttributedString string: NSAttributedString) -> NSMutableAttributedString {
    return NSMutableAttributedString(attributedString: string)
   
}
public func makeNSRange<T: RangeExpression>(rangeExpression: T) -> NSRange where T.Bound: FixedWidthInteger {
    return NSRange(rangeExpression)
}
 
