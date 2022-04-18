//
//  NSMutableAttributeStringAdds.swift
//  LithoStrings
//
//  Created by Remmington Damper on 1/26/22.
//

import Foundation
import UIKit

public func setForegroundColorAttributes(color: UIColor, string: NSMutableAttributedString){
    string.addAttributes(foregroundColorAttr(color: color), range: NSMakeRange(0, string.length))
}
public func setAttachmentAttributes(attachment: NSTextAttachment, string: NSMutableAttributedString){
    string.addAttributes(attachmentAttr(forAttachment: attachment), range: NSMakeRange(0, string.length))
}
public func setbackgroundColorAttributes(color: UIColor, string: NSMutableAttributedString) -> Void {
    string.addAttributes(backgroundColorForAttr(color: color), range: NSMakeRange(0, string.length))
}
public func setBaselineoffsetAttributes(offset: NSNumber, string: NSMutableAttributedString) -> Void {
    string.addAttributes(baselineOffsetStyling(offset: offset), range: NSMakeRange(0, string.length))
}
public func setExpansionAttributes(expansion: NSNumber, string: NSMutableAttributedString) -> Void {
    string.addAttributes(expansionStyling(expansion: expansion), range: NSMakeRange(0, string.length))
}
public func setFontAttributes(font: UIFont, string: NSMutableAttributedString) -> Void {
    string.addAttributes(fontForAttributedString(font: font), range: NSMakeRange(0, string.length))
}
public func setKernAttributes(kern: NSNumber, string: NSMutableAttributedString) -> Void {
    string.addAttributes(kernForText(kern: kern), range: NSMakeRange(0, string.length))
}
public func setLigatureAttributes(ligature: NSNumber, string: NSMutableAttributedString) -> Void {
    string.addAttributes(ligatureForText(ligature: ligature), range: NSMakeRange(0, string.length))
}
public func setLinkAttributes(link: NSURL, string: NSMutableAttributedString) -> Void {
    string.addAttributes(linkForText(link: link), range: NSMakeRange(0, string.length))
}
public func setObliquenessAttributes(obliqueness: NSNumber, string: NSMutableAttributedString) -> Void {
    string.addAttributes(obliquenessForTextStyle(obliqueness: obliqueness), range: NSMakeRange(0, string.length))
}
public func setParagraphStyleAttributes(style: NSParagraphStyle, string: NSMutableAttributedString) -> Void {
    string.addAttributes(paragraphStyleForText(style: style), range: NSMakeRange(0, string.length))
}
public func setShadowAttributes(shadow: NSShadow, string: NSMutableAttributedString) -> Void {
    string.addAttributes(shadowForTextStyle(shadow: shadow), range: NSMakeRange(0, string.length))
}
public func setStrikethroughColorAttributes(color: UIColor, string: NSMutableAttributedString) -> Void {
    string.addAttributes(strokeColorForTextAttr(color: color), range: NSMakeRange(0, string.length))
}
public func setStrikethroughStyleAttributes(style: NSNumber, string: NSMutableAttributedString) -> Void {
    string.addAttributes(strikethroughStyleForText(style: style), range: NSMakeRange(0, string.length))
}
public func setStrokeColorAttributes(color: UIColor, string: NSMutableAttributedString) -> Void {
    string.addAttributes(strokeColorForTextAttr(color: color), range: NSMakeRange(0, string.length))
}
public func setStrokeWidthAttributes(width: NSNumber, string: NSMutableAttributedString) -> Void {
    string.addAttributes(strokeWidthForTextAttr(width: width), range: NSMakeRange(0, string.length))
}
public func setTextEffectAttributes(effect: NSString, string: NSMutableAttributedString) -> Void {
    string.addAttributes(textEffectForTextAttr(effect: effect), range: NSMakeRange(0, string.length))
}
public func setUnderlineColorAttributes(color: UIColor, string: NSMutableAttributedString) -> Void {
    string.addAttributes(underlineColorForTextAttr(color: color), range: NSMakeRange(0, string.length))
}
public func setUnderlineStyleAttributes(style: NSNumber, string: NSMutableAttributedString) -> Void {
    string.addAttributes(underlineStyleForTextAttr(style: style), range: NSMakeRange(0, string.length))
}
public func setVerticalGlyphFormAttributes(style: NSNumber, string: NSMutableAttributedString) -> Void {
    string.addAttributes(verticalGlyphFormForText(form: style), range: NSMakeRange(0, string.length))
}
public func setWritingDirectionAttributes(direction: NSArray, string: NSMutableAttributedString) -> Void {
    string.addAttributes(writingDirectionStyle(direction: direction), range: NSMakeRange(0, string.length))
}
