//
//  CodableViewStyle.swift
//  LithoUtils
//
//  Created by Elliot on 12/29/21.
//

import UIKit
import Prelude
import LithoOperators

public protocol CodableViewStyleProtocol {
    var backgroundColorHex: String? { get set }
    var tintColorHex: String? { get set }
    
    var isHidden: Bool? { get set }
    var isOpaque: Bool? { get set }
    var clipsToBounds: Bool? { get set }
    
    var alpha: CGFloat? { get set }
    
    var cornerRadius: CGFloat? { get set }
    var isRounded: Bool? { get set }
    
    var borderWidth: CGFloat? { get set }
    var borderColorHex: String? { get set }
    
    var shadowColorHex: String? { get set }
    var shadowRadius: CGFloat? { get set }
    var shadowOpacity: Float? { get set }
    
    func apply(to view: UIView?)
}

open class CodableViewStyle: CodableViewStyleProtocol, Codable {
    open var backgroundColorHex: String?
    open var tintColorHex: String?
    
    open var isHidden: Bool?
    open var isOpaque: Bool?
    open var clipsToBounds: Bool?
    
    open var alpha: CGFloat?
    
    open var cornerRadius: CGFloat?
    open var isRounded: Bool?
    
    open var borderWidth: CGFloat?
    open var borderColorHex: String?
    
    open var shadowColorHex: String?
    open var shadowRadius: CGFloat?
    open var shadowOpacity: Float?
    
    public init() {}
    
    public func apply(to view: UIView?) {
        view |> styleFunction(given: self)
    }
}

public func styleFunction(given style: CodableViewStyleProtocol) -> (UIView?) -> Void {
    let doNothing: (UIView) -> Void = { _ in }
    var result: (UIView) -> Void = doNothing
    
    result <>= style.backgroundColorHex ?> (UIColor.init(hexString:) >>> (\UIView.backgroundColor *-> set))
    result <>= style.tintColorHex ?> (UIColor.init(hexString:) >>> (\UIView.tintColor *-> set))
    
    result <>= style.isHidden ?> (\UIView.isHidden *-> set)
    result <>= style.isOpaque ?> (\UIView.isOpaque *-> set)
    result <>= style.clipsToBounds ?> (\UIView.clipsToBounds *-> set)
    
    result <>= (style.alpha ?> (\UIView.alpha *-> set))
    
    result <>= style.cornerRadius ?> (\UIView.layer.cornerRadius *-> set)
    result <>= style.isRounded ?> ((setCappedEnds, nil) -**> ifThen)
    
    result <>= style.borderColorHex |> (~>UIColor.init(hexString:) >?> ^\UIColor.cgColor >>> (\UIView.layer.borderColor *-> set))
    result <>= style.borderWidth ?> (\UIView.layer.borderWidth *-> set)
    
    result <>= style.shadowColorHex |> (~>UIColor.init(hexString:) >?> ^\UIColor.cgColor >>> (\UIView.layer.shadowColor *-> set))
    result <>= style.shadowRadius ?> (\UIView.layer.shadowRadius *-> set)
    result <>= style.shadowOpacity ?> (\UIView.layer.shadowOpacity *-> set)
    
    return ~>result
}
