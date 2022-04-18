//
//  NSAttributesReturnFunctions.swift
//  LithoStrings
//
//  Created by Remmington Damper on 1/26/22.
//

import Foundation
import UIKit

public func foregroundColorAttr(color: UIColor) -> [NSAttributedString.Key: Any] {
    return [.foregroundColor: color]
}
public func attachmentAttr(forAttachment: NSTextAttachment) -> [NSAttributedString.Key: Any] {
    return [.attachment: forAttachment]
}
public func backgroundColorForAttr(color: UIColor) -> [NSAttributedString.Key: Any] {
    return [.backgroundColor: color]
}
public func baselineOffsetStyling(offset: NSNumber) -> [NSAttributedString.Key: Any] {
    return [.baselineOffset: offset]
}
public func expansionStyling(expansion: NSNumber) -> [NSAttributedString.Key: Any] {
    return [.expansion: expansion]
}
public func fontForAttributedString(font: UIFont) -> [NSAttributedString.Key: Any] {
    return [.font: font]
}
public func kernForText(kern: NSNumber) -> [NSAttributedString.Key: Any] {
    return [.kern: kern]
}
public func ligatureForText(ligature: NSNumber) -> [NSAttributedString.Key: Any] {
    return [.ligature: ligature]
}
public func linkForText(link: NSURL) -> [NSAttributedString.Key: Any] {
    return [.link: link]
}
public func obliquenessForTextStyle(obliqueness: NSNumber) -> [NSAttributedString.Key: Any] {
    return [.obliqueness: obliqueness]
}
public func paragraphStyleForText(style: NSParagraphStyle) -> [NSAttributedString.Key: Any] {
    return [.paragraphStyle: style]
}
public func shadowForTextStyle(shadow: NSShadow) -> [NSAttributedString.Key: Any] {
    return [.shadow: shadow]
}
public func strikethroughColorForText(color: UIColor) -> [NSAttributedString.Key: Any] {
    return [.strikethroughColor: color]
}
public func strikethroughStyleForText(style: NSNumber) -> [NSAttributedString.Key: Any] {
    return [.strikethroughStyle: style]
}
public func strokeColorForTextAttr(color: UIColor) -> [NSAttributedString.Key: Any] {
    return [.strokeColor: color]
}
public func strokeWidthForTextAttr(width: NSNumber) -> [NSAttributedString.Key: Any] {
    return [.strokeWidth: width]
}
public func textEffectForTextAttr(effect: NSString) -> [NSAttributedString.Key: Any] {
    return [.textEffect: effect]
}
public func underlineColorForTextAttr(color: UIColor) -> [NSAttributedString.Key: Any] {
    return [.underlineColor: color]
}
public func underlineStyleForTextAttr(style: NSNumber) -> [NSAttributedString.Key: Any] {
    return [.underlineStyle: style]
}
public func verticalGlyphFormForText(form: NSNumber) -> [NSAttributedString.Key: Any] {
    return [.verticalGlyphForm: form]
}
public func writingDirectionStyle(direction: NSArray) -> [NSAttributedString.Key: Any] {
    return [.writingDirection: direction]
}




 
