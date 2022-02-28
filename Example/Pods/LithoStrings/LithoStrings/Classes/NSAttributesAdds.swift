//
//  NSAttributesAdds.swift
//  LithoStrings
//
//  Created by Remmington Damper on 1/26/22.
//

import Foundation
import UIKit

public func addForegroundColorToAttributes(color: UIColor, attributes: inout [NSAttributedString.Key: Any]) -> Void {
    attributes[.foregroundColor] = color
}
public func addAttachmentAttributes(attachment: NSTextAttachment, attributes: inout [NSAttributedString.Key: Any]) -> Void {
    attributes[.attachment] = attachment
}
public func addBackgroundColorToAttributes(color: UIColor, attributes: inout [NSAttributedString.Key: Any]) -> Void {
    attributes[.backgroundColor] = color
}
public func addBaselineOffsetToAttributes(offset: NSNumber, attributes: inout [NSAttributedString.Key: Any]) -> Void {
    attributes[.baselineOffset] = offset
}
public func addExpansionToAttributes(expansion: NSNumber, attributes: inout [NSAttributedString.Key: Any]) -> Void {
    attributes[.expansion] = expansion
}
public func addFontToAttributes(font: UIFont, attributes: inout [NSAttributedString.Key: Any]) -> Void {
    attributes[.font] = font
}
public func addKernToAttributes(kern: NSNumber, attributes: inout [NSAttributedString.Key: Any]) -> Void {
    attributes[.kern] = kern
}
public func addLigatureToAttributes(ligature: NSNumber, attributes: inout [NSAttributedString.Key: Any]) -> Void {
    attributes[.ligature] = ligature
}
public func addLinkToAttributes(link: NSURL, attributes: inout [NSAttributedString.Key: Any]) -> Void {
    attributes[.link] = link
}
public func addObliquenessToAttributes(obliqueness: NSNumber, attributes: inout [NSAttributedString.Key: Any]) -> Void {
    attributes[.obliqueness] = obliqueness
}
public func addParagraphStyleToAttributes(paragraphStyle: NSParagraphStyle, attributes: inout [NSAttributedString.Key: Any]) -> Void {
    attributes[.paragraphStyle] = paragraphStyle
}
public func addShadowToAttributes(shadow: NSShadow, attributes: inout [NSAttributedString.Key: Any]) -> Void {
    attributes[.shadow] = shadow
}
public func addStrikeThroughColorToAttributes(color: UIColor, attributes: inout [NSAttributedString.Key: Any]) -> Void {
    attributes[.strikethroughColor] = color
}
public func addStrikeThroughStyleToAttributes(style: NSNumber, attributes: inout [NSAttributedString.Key: Any]) -> Void {
    attributes[.strikethroughStyle] = style
}
public func addStrokeColorToAttributes(color: UIColor, attributes: inout [NSAttributedString.Key: Any]) -> Void {
    attributes[.strokeColor] = color
}
public func addStrokeWidthToAttributes(width: NSNumber, attributes: inout [NSAttributedString.Key: Any]) -> Void {
    attributes[.strokeWidth] = width
}
public func addTextEffectToAttributes(effect: NSString, attributes: inout [NSAttributedString.Key: Any]) -> Void {
    attributes[.textEffect] = effect
}
public func addUnderlineColorToAttributes(color: UIColor, attributes: inout [NSAttributedString.Key: Any]) -> Void {
    attributes[.underlineColor] = color
}
public func addUnderlineStyleToAttributes(style: NSNumber, attributes: inout [NSAttributedString.Key: Any]) -> Void {
    attributes[.underlineStyle] = style
}
public func addVerticalGlyphFormToAttributes(style: NSNumber, attributes: inout [NSAttributedString.Key: Any]) -> Void {
    attributes[.verticalGlyphForm] = style
}
public func addWritingDirectionToAttributes(direction: NSArray, attributes: inout [NSAttributedString.Key: Any]) -> Void {
    attributes[.writingDirection] = direction
}
