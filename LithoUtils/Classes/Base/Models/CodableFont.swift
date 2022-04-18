//
//  CodableFont.swift
//  LithoUtils
//
//  Created by Remmington Damper on 1/15/22.
//

import Foundation
import Prelude
import LithoOperators

public struct CodableFont: Codable {
    public var name: String?
    public var size: CGFloat?
    
    public var setOnLabel: ((UILabel?) -> Void)? {
        get { return ~>set(\UILabel.font, font()) }
    }
    public var setOnTextView: ((UITextView?) -> Void)? {
        get { return ~>set(\UITextView.font, font()) }
    }
    public var setOnTextField: ((UITextField?) -> Void)? {
        get { return ~>set(\UITextField.font, font()) }
    }
    public var setOnButton: ((UIButton?) -> Void)? {
        get { return { button in
            if let title = button?.titleLabel?.attributedText {
                let attributed = NSMutableAttributedString(attributedString: title)
                attributed.addAttributes([.font : font()!], range: NSMakeRange(0, attributed.length))
                button?.setAttributedTitle(attributed, for: .normal)
            }
        }}
    }
    public var setOnButtonWithTitle: ((UIButton?, String) -> Void)? {
        get { return { button, title in
            let attributed = NSAttributedString(string: title, attributes: [.font : font()!])
            button?.setAttributedTitle(attributed, for: .normal)
        }}
    }
    
    public init(name: String?, size: CGFloat?) {
        self.name = name
        self.size = size
    }
    
    public func font() -> UIFont? {
        if let fontName = name, let fontSize = size {
            return UIFont(name: fontName, size: fontSize)
        }
        return nil
    }
}
