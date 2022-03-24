//
//  CodableViewTests.swift
//  LithoUtils_Tests
//
//  Created by Elliot on 3/22/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest
import LithoOperators
import Prelude
@testable import LithoUtils

class CodableViewTests: XCTestCase {

    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}
    
    func testNoCodableView() throws {
        guard let data = dictToData([:]) else { XCTFail(); return }
        guard let codableStyle = try? JSONDecoder().decode(CodableViewStyle.self, from: data) else { XCTFail(); return }
        let view = UIView()
        
        view.backgroundColor = .black
        view.tintColor = .orange
        view.isHidden = true
        view.isOpaque = false
        view.clipsToBounds = true
        view.alpha = 0.4
        view.layer.cornerRadius = 2
        view.layer.borderColor = UIColor.orange.cgColor
        view.layer.borderWidth = 3
        view.layer.shadowColor = UIColor.orange.cgColor
        view.layer.shadowRadius = 7
        view.layer.shadowOpacity = 0.2
        
        let backgroundColor = view.backgroundColor
        let tintColor = view.tintColor
        let isHidden = view.isHidden
        let isOpaque = view.isOpaque
        let clipsToBounds = view.clipsToBounds
        let alpha = view.alpha
        let cornerRadius = view.layer.cornerRadius
        let borderColor = view.layer.borderColor
        let borderWidth = view.layer.borderWidth
        let shadowColor = view.layer.shadowColor
        let shadowRadius = view.layer.shadowRadius
        let shadowOpacity = view.layer.shadowOpacity

        codableStyle.apply(to: view)
        
        XCTAssertEqual(view.backgroundColor, backgroundColor)
        XCTAssertEqual(view.tintColor, tintColor)
        XCTAssertEqual(view.isHidden, isHidden)
        XCTAssertEqual(view.isOpaque, isOpaque)
        XCTAssertEqual(view.clipsToBounds, clipsToBounds)
        XCTAssertEqual(view.alpha, alpha)
        XCTAssertEqual(view.layer.cornerRadius, cornerRadius)
        XCTAssertEqual(view.layer.borderColor, borderColor)
        XCTAssertEqual(view.layer.borderWidth, borderWidth)
        XCTAssertEqual(view.layer.shadowColor, shadowColor)
        XCTAssertEqual(view.layer.shadowRadius, shadowRadius)
        XCTAssertEqual(view.layer.shadowOpacity, shadowOpacity)
    }
    
    func testNilCodableView() throws {
        guard let data = dictToData([:]) else { XCTFail(); return }
        guard let codableStyle = try? JSONDecoder().decode(CodableViewStyle.self, from: data) else { XCTFail(); return }
        let view: UIView? = UIView()
        let backgroundColor = view?.backgroundColor
        let tintColor = view?.tintColor
        let isHidden = view?.isHidden
        let isOpaque = view?.isOpaque
        let clipsToBounds = view?.clipsToBounds
        let alpha = view?.alpha
        let cornerRadius = view?.layer.cornerRadius
        let borderColor = view?.layer.borderColor
        let borderWidth = view?.layer.borderWidth
        let shadowColor = view?.layer.shadowColor
        let shadowRadius = view?.layer.shadowRadius
        let shadowOpacity = view?.layer.shadowOpacity

        codableStyle.apply(to: view)
        
        XCTAssertEqual(view?.backgroundColor, backgroundColor)
        XCTAssertEqual(view?.tintColor, tintColor)
        XCTAssertEqual(view?.isHidden, isHidden)
        XCTAssertEqual(view?.isOpaque, isOpaque)
        XCTAssertEqual(view?.clipsToBounds, clipsToBounds)
        XCTAssertEqual(view?.alpha, alpha)
        XCTAssertEqual(view?.layer.cornerRadius, cornerRadius)
        XCTAssertEqual(view?.layer.borderColor, borderColor)
        XCTAssertEqual(view?.layer.borderWidth, borderWidth)
        XCTAssertEqual(view?.layer.shadowColor, shadowColor)
        XCTAssertEqual(view?.layer.shadowRadius, shadowRadius)
        XCTAssertEqual(view?.layer.shadowOpacity, shadowOpacity)
    }
    
    func testCodableView() throws {
        guard let data = dictToData(codableViewJson) else { XCTFail(); return }
        guard let codableStyle = try? JSONDecoder().decode(CodableViewStyle.self, from: data) else { XCTFail(); return }
        let view = UIView()
        
        codableStyle.apply(to: view)
        
        XCTAssertEqual(view.backgroundColor, UIColor.red)
        XCTAssertEqual(view.tintColor, UIColor.green)
        XCTAssertEqual(view.isHidden, codableViewJson["isHidden"] as? Bool)
        XCTAssertEqual(view.isOpaque, codableViewJson["isOpaque"] as? Bool)
        XCTAssertEqual(view.clipsToBounds, codableViewJson["clipsToBounds"] as? Bool)
        XCTAssertEqual(view.alpha, CGFloat(codableViewJson["alpha"] as! Double))
        XCTAssertEqual(view.layer.cornerRadius, CGFloat(codableViewJson["cornerRadius"] as! Int))
        XCTAssertEqual(view.layer.borderColor, UIColor.yellow.cgColor)
        XCTAssertEqual(view.layer.borderWidth, CGFloat(codableViewJson["borderWidth"] as! Int))
        XCTAssertEqual(view.layer.shadowColor, UIColor(hexString: "800080").cgColor)
        XCTAssertEqual(view.layer.shadowRadius, CGFloat(codableViewJson["shadowRadius"] as! Int))
        XCTAssertEqual(view.layer.shadowOpacity, Float(codableViewJson["shadowOpacity"] as! Double))
    }
    
    func testCodableLabel() throws {
        guard let data = dictToData(codableLabelJson) else { XCTFail(); return }
        guard let codableStyle = try? JSONDecoder().decode(CodableLabelStyle.self, from: data) else { XCTFail(); return }
        let view = UILabel()
        
        codableStyle.apply(to: view)
        
        XCTAssertEqual(view.backgroundColor, UIColor.red)
        XCTAssertEqual(view.tintColor, UIColor.green)
        XCTAssertEqual(view.isHidden, codableViewJson["isHidden"] as? Bool)
        XCTAssertEqual(view.isOpaque, codableViewJson["isOpaque"] as? Bool)
        XCTAssertEqual(view.clipsToBounds, codableViewJson["clipsToBounds"] as? Bool)
        XCTAssertEqual(view.alpha, CGFloat(codableViewJson["alpha"] as! Double))
        XCTAssertEqual(view.layer.cornerRadius, CGFloat(codableViewJson["cornerRadius"] as! Int))
        XCTAssertEqual(view.layer.borderColor, UIColor.yellow.cgColor)
        XCTAssertEqual(view.layer.borderWidth, CGFloat(codableViewJson["borderWidth"] as! Int))
        XCTAssertEqual(view.layer.shadowColor, UIColor(hexString: "800080").cgColor)
        XCTAssertEqual(view.layer.shadowRadius, CGFloat(codableViewJson["shadowRadius"] as! Int))
        XCTAssertEqual(view.layer.shadowOpacity, Float(codableViewJson["shadowOpacity"] as! Double))
        
        XCTAssertEqual(view.textColor, UIColor.blue)
        XCTAssertEqual(view.shadowColor, UIColor.blue)
        XCTAssertEqual(view.font.fontName, codableAvenir["name"] as? String)
    }
    
    func testNoCodableLabel() throws {
        guard let data = dictToData([:]) else { XCTFail(); return }
        guard let codableStyle = try? JSONDecoder().decode(CodableViewStyle.self, from: data) else { XCTFail(); return }
        let view = UILabel()
        
        view.backgroundColor = .black
        view.tintColor = .orange
        view.isHidden = true
        view.isOpaque = false
        view.clipsToBounds = true
        view.alpha = 0.4
        view.layer.cornerRadius = 2
        view.layer.borderColor = UIColor.orange.cgColor
        view.layer.borderWidth = 3
        view.layer.shadowColor = UIColor.orange.cgColor
        view.layer.shadowRadius = 7
        view.layer.shadowOpacity = 0.2
        
        view.textColor = UIColor.blue
        view.shadowColor = UIColor.blue
        view.font = UIFont(name: "Avenir-Medium", size: 21)
        
        let backgroundColor = view.backgroundColor
        let tintColor = view.tintColor
        let isHidden = view.isHidden
        let isOpaque = view.isOpaque
        let clipsToBounds = view.clipsToBounds
        let alpha = view.alpha
        let cornerRadius = view.layer.cornerRadius
        let borderColor = view.layer.borderColor
        let borderWidth = view.layer.borderWidth
        let shadowColor = view.layer.shadowColor
        let shadowRadius = view.layer.shadowRadius
        let shadowOpacity = view.layer.shadowOpacity
        
        let textColor = view.textColor
        let labelShadowColor = view.shadowColor
        let fontName = view.font.fontName

        codableStyle.apply(to: view)
        
        XCTAssertEqual(view.backgroundColor, backgroundColor)
        XCTAssertEqual(view.tintColor, tintColor)
        XCTAssertEqual(view.isHidden, isHidden)
        XCTAssertEqual(view.isOpaque, isOpaque)
        XCTAssertEqual(view.clipsToBounds, clipsToBounds)
        XCTAssertEqual(view.alpha, alpha)
        XCTAssertEqual(view.layer.cornerRadius, cornerRadius)
        XCTAssertEqual(view.layer.borderColor, borderColor)
        XCTAssertEqual(view.layer.borderWidth, borderWidth)
        XCTAssertEqual(view.layer.shadowColor, shadowColor)
        XCTAssertEqual(view.layer.shadowRadius, shadowRadius)
        XCTAssertEqual(view.layer.shadowOpacity, shadowOpacity)
        
        XCTAssertEqual(view.textColor, textColor)
        XCTAssertEqual(view.shadowColor, labelShadowColor)
        XCTAssertEqual(view.font.fontName, fontName)
    }
    
    func testCodableTextField() throws {
        guard let data = dictToData(codableTextFieldJson) else { XCTFail(); return }
        guard let codableStyle = try? JSONDecoder().decode(CodableTextFieldStyle.self, from: data) else { XCTFail(); return }
        let view = UITextField()
        
        codableStyle.apply(to: view)
        
        XCTAssertEqual(view.backgroundColor, UIColor.red)
        XCTAssertEqual(view.tintColor, UIColor.green)
        XCTAssertEqual(view.isHidden, codableViewJson["isHidden"] as? Bool)
        XCTAssertEqual(view.isOpaque, codableViewJson["isOpaque"] as? Bool)
        XCTAssertEqual(view.clipsToBounds, codableViewJson["clipsToBounds"] as? Bool)
        XCTAssertEqual(view.alpha, CGFloat(codableViewJson["alpha"] as! Double))
        XCTAssertEqual(view.layer.cornerRadius, CGFloat(codableViewJson["cornerRadius"] as! Int))
        XCTAssertEqual(view.layer.borderColor, UIColor.yellow.cgColor)
        XCTAssertEqual(view.layer.borderWidth, CGFloat(codableViewJson["borderWidth"] as! Int))
        XCTAssertEqual(view.layer.shadowColor, UIColor(hexString: "800080").cgColor)
        XCTAssertEqual(view.layer.shadowRadius, CGFloat(codableViewJson["shadowRadius"] as! Int))
        XCTAssertEqual(view.layer.shadowOpacity, Float(codableViewJson["shadowOpacity"] as! Double))
        
        XCTAssertEqual(view.textColor, UIColor.blue)
        XCTAssertEqual(view.borderStyle, .line)
        XCTAssertEqual(view.font?.fontName, codableAvenir["name"] as? String)
    }
    
    func testNoCodableTextField() throws {
        guard let data = dictToData([:]) else { XCTFail(); return }
        guard let codableStyle = try? JSONDecoder().decode(CodableViewStyle.self, from: data) else { XCTFail(); return }
        let view = UITextField()
        
        view.backgroundColor = .black
        view.tintColor = .orange
        view.isHidden = true
        view.isOpaque = false
        view.clipsToBounds = true
        view.alpha = 0.4
        view.layer.cornerRadius = 2
        view.layer.borderColor = UIColor.orange.cgColor
        view.layer.borderWidth = 3
        view.layer.shadowColor = UIColor.orange.cgColor
        view.layer.shadowRadius = 7
        view.layer.shadowOpacity = 0.2
        
        view.textColor = UIColor.blue
        view.borderStyle = .line
        view.font = UIFont(name: "Avenir-Medium", size: 21)
        
        let backgroundColor = view.backgroundColor
        let tintColor = view.tintColor
        let isHidden = view.isHidden
        let isOpaque = view.isOpaque
        let clipsToBounds = view.clipsToBounds
        let alpha = view.alpha
        let cornerRadius = view.layer.cornerRadius
        let borderColor = view.layer.borderColor
        let borderWidth = view.layer.borderWidth
        let shadowColor = view.layer.shadowColor
        let shadowRadius = view.layer.shadowRadius
        let shadowOpacity = view.layer.shadowOpacity
        
        let textColor = view.textColor
        let borderStyle = view.borderStyle
        let fontName = view.font?.fontName
        
        codableStyle.apply(to: view)
        
        XCTAssertEqual(view.backgroundColor, backgroundColor)
        XCTAssertEqual(view.tintColor, tintColor)
        XCTAssertEqual(view.isHidden, isHidden)
        XCTAssertEqual(view.isOpaque, isOpaque)
        XCTAssertEqual(view.clipsToBounds, clipsToBounds)
        XCTAssertEqual(view.alpha, alpha)
        XCTAssertEqual(view.layer.cornerRadius, cornerRadius)
        XCTAssertEqual(view.layer.borderColor, borderColor)
        XCTAssertEqual(view.layer.borderWidth, borderWidth)
        XCTAssertEqual(view.layer.shadowColor, shadowColor)
        XCTAssertEqual(view.layer.shadowRadius, shadowRadius)
        XCTAssertEqual(view.layer.shadowOpacity, shadowOpacity)
        
        XCTAssertEqual(view.textColor, textColor)
        XCTAssertEqual(view.borderStyle, borderStyle)
        XCTAssertEqual(view.font?.fontName, fontName)
    }
    
    func testCodableTextView() throws {
        guard let data = dictToData(codableTextViewJson) else { XCTFail(); return }
        guard let codableStyle = try? JSONDecoder().decode(CodableTextViewStyle.self, from: data) else { XCTFail(); return }
        let view = UITextView()
        
        codableStyle.apply(to: view)
        
        XCTAssertEqual(view.backgroundColor, UIColor.red)
        XCTAssertEqual(view.tintColor, UIColor.green)
        XCTAssertEqual(view.isHidden, codableViewJson["isHidden"] as? Bool)
        XCTAssertEqual(view.isOpaque, codableViewJson["isOpaque"] as? Bool)
        XCTAssertEqual(view.clipsToBounds, codableViewJson["clipsToBounds"] as? Bool)
        XCTAssertEqual(view.alpha, CGFloat(codableViewJson["alpha"] as! Double))
        XCTAssertEqual(view.layer.cornerRadius, CGFloat(codableViewJson["cornerRadius"] as! Int))
        XCTAssertEqual(view.layer.borderColor, UIColor.yellow.cgColor)
        XCTAssertEqual(view.layer.borderWidth, CGFloat(codableViewJson["borderWidth"] as! Int))
        XCTAssertEqual(view.layer.shadowColor, UIColor(hexString: "800080").cgColor)
        XCTAssertEqual(view.layer.shadowRadius, CGFloat(codableViewJson["shadowRadius"] as! Int))
        XCTAssertEqual(view.layer.shadowOpacity, Float(codableViewJson["shadowOpacity"] as! Double))
        
        XCTAssertEqual(view.textColor, UIColor.blue)
        XCTAssertEqual(view.font?.fontName, codableAvenir["name"] as? String)
    }
    
    func testNoCodableTextView() throws {
        guard let data = dictToData([:]) else { XCTFail(); return }
        guard let codableStyle = try? JSONDecoder().decode(CodableViewStyle.self, from: data) else { XCTFail(); return }
        let view = UITextView()
        
        view.backgroundColor = .black
        view.tintColor = .orange
        view.isHidden = true
        view.isOpaque = false
        view.clipsToBounds = true
        view.alpha = 0.4
        view.layer.cornerRadius = 2
        view.layer.borderColor = UIColor.orange.cgColor
        view.layer.borderWidth = 3
        view.layer.shadowColor = UIColor.orange.cgColor
        view.layer.shadowRadius = 7
        view.layer.shadowOpacity = 0.2
        
        view.textColor = UIColor.blue
        view.font = UIFont(name: "Avenir-Medium", size: 21)
        
        let backgroundColor = view.backgroundColor
        let tintColor = view.tintColor
        let isHidden = view.isHidden
        let isOpaque = view.isOpaque
        let clipsToBounds = view.clipsToBounds
        let alpha = view.alpha
        let cornerRadius = view.layer.cornerRadius
        let borderColor = view.layer.borderColor
        let borderWidth = view.layer.borderWidth
        let shadowColor = view.layer.shadowColor
        let shadowRadius = view.layer.shadowRadius
        let shadowOpacity = view.layer.shadowOpacity
        
        let textColor = view.textColor
        let fontName = view.font?.fontName

        codableStyle.apply(to: view)
        
        XCTAssertEqual(view.backgroundColor, backgroundColor)
        XCTAssertEqual(view.tintColor, tintColor)
        XCTAssertEqual(view.isHidden, isHidden)
        XCTAssertEqual(view.isOpaque, isOpaque)
        XCTAssertEqual(view.clipsToBounds, clipsToBounds)
        XCTAssertEqual(view.alpha, alpha)
        XCTAssertEqual(view.layer.cornerRadius, cornerRadius)
        XCTAssertEqual(view.layer.borderColor, borderColor)
        XCTAssertEqual(view.layer.borderWidth, borderWidth)
        XCTAssertEqual(view.layer.shadowColor, shadowColor)
        XCTAssertEqual(view.layer.shadowRadius, shadowRadius)
        XCTAssertEqual(view.layer.shadowOpacity, shadowOpacity)
        
        XCTAssertEqual(view.textColor, textColor)
        XCTAssertEqual(view.font?.fontName, fontName)
    }
    
    func testCodableButton() throws {
        guard let data = dictToData(codableButtonJson) else { XCTFail(); return }
        guard let codableStyle = try? JSONDecoder().decode(CodableButtonStyle.self, from: data) else { XCTFail(); return }
        let view = UIButton()
        
        codableStyle.apply(to: view)
        
        XCTAssertEqual(view.backgroundColor, UIColor.red)
        XCTAssertEqual(view.tintColor, UIColor.green)
        XCTAssertEqual(view.isHidden, codableViewJson["isHidden"] as? Bool)
        XCTAssertEqual(view.isOpaque, codableViewJson["isOpaque"] as? Bool)
        XCTAssertEqual(view.clipsToBounds, codableViewJson["clipsToBounds"] as? Bool)
        XCTAssertEqual(view.alpha, CGFloat(codableViewJson["alpha"] as! Double))
        XCTAssertEqual(view.layer.cornerRadius, CGFloat(codableViewJson["cornerRadius"] as! Int))
        XCTAssertEqual(view.layer.borderColor, UIColor.yellow.cgColor)
        XCTAssertEqual(view.layer.borderWidth, CGFloat(codableViewJson["borderWidth"] as! Int))
        XCTAssertEqual(view.layer.shadowColor, UIColor(hexString: "800080").cgColor)
        XCTAssertEqual(view.layer.shadowRadius, CGFloat(codableViewJson["shadowRadius"] as! Int))
        XCTAssertEqual(view.layer.shadowOpacity, Float(codableViewJson["shadowOpacity"] as! Double))
    }
    
    func testNoCodableButton() throws {
        guard let data = dictToData([:]) else { XCTFail(); return }
        guard let codableStyle = try? JSONDecoder().decode(CodableViewStyle.self, from: data) else { XCTFail(); return }
        let view = UIButton()
        
        view.backgroundColor = .black
        view.tintColor = .orange
        view.isHidden = true
        view.isOpaque = false
        view.clipsToBounds = true
        view.alpha = 0.4
        view.layer.cornerRadius = 2
        view.layer.borderColor = UIColor.orange.cgColor
        view.layer.borderWidth = 3
        view.layer.shadowColor = UIColor.orange.cgColor
        view.layer.shadowRadius = 7
        view.layer.shadowOpacity = 0.2
        
        let backgroundColor = view.backgroundColor
        let tintColor = view.tintColor
        let isHidden = view.isHidden
        let isOpaque = view.isOpaque
        let clipsToBounds = view.clipsToBounds
        let alpha = view.alpha
        let cornerRadius = view.layer.cornerRadius
        let borderColor = view.layer.borderColor
        let borderWidth = view.layer.borderWidth
        let shadowColor = view.layer.shadowColor
        let shadowRadius = view.layer.shadowRadius
        let shadowOpacity = view.layer.shadowOpacity

        codableStyle.apply(to: view)
        
        XCTAssertEqual(view.backgroundColor, backgroundColor)
        XCTAssertEqual(view.tintColor, tintColor)
        XCTAssertEqual(view.isHidden, isHidden)
        XCTAssertEqual(view.isOpaque, isOpaque)
        XCTAssertEqual(view.clipsToBounds, clipsToBounds)
        XCTAssertEqual(view.alpha, alpha)
        XCTAssertEqual(view.layer.cornerRadius, cornerRadius)
        XCTAssertEqual(view.layer.borderColor, borderColor)
        XCTAssertEqual(view.layer.borderWidth, borderWidth)
        XCTAssertEqual(view.layer.shadowColor, shadowColor)
        XCTAssertEqual(view.layer.shadowRadius, shadowRadius)
        XCTAssertEqual(view.layer.shadowOpacity, shadowOpacity)
    }
}

func dictToData(_ dictionary: [String: Any]) -> Data? {
    return try? JSONSerialization.data(withJSONObject: dictionary)
}

let codableViewJson: [String: Any] = ["backgroundColorHex": "#FF0000",
                                      "tintColorHex": "#00FF00",
                                      "isHidden": true,
                                      "isOpaque": false,
                                      "clipsToBounds": true,
                                      "alpha": 0.75,
                                      "cornerRadius": 8,
                                      "borderWidth": 1,
                                      "borderColorHex": "#FFFF00",
                                      "shadowColorHex": "#800080",
                                      "shadowRadius": 6,
                                      "shadowOpacity": 0.1]

let codableLabelJson: [String: Any] = ["backgroundColorHex": "#FF0000",
                                       "tintColorHex": "#00FF00",
                                       "isHidden": true,
                                       "isOpaque": false,
                                       "clipsToBounds": true,
                                       "alpha": 0.75,
                                       "cornerRadius": 8,
                                       "borderWidth": 1,
                                       "borderColorHex": "#FFFF00",
                                       "shadowColorHex": "#800080",
                                       "shadowRadius": 6,
                                       "shadowOpacity": 0.1,
                                       "font": codableAvenir,
                                       "textColor": "#0000FF",
                                       "labelShadowColor": "#0000FF"]

let codableTextFieldJson: [String: Any] = ["backgroundColorHex": "#FF0000",
                                           "tintColorHex": "#00FF00",
                                           "isHidden": true,
                                           "isOpaque": false,
                                           "clipsToBounds": true,
                                           "alpha": 0.75,
                                           "cornerRadius": 8,
                                           "borderWidth": 1,
                                           "borderColorHex": "#FFFF00",
                                           "shadowColorHex": "#800080",
                                           "shadowRadius": 6,
                                           "shadowOpacity": 0.1,
                                           "font": codableAvenir,
                                           "textColor": "#0000FF",
                                           "borderStyle": 1]

let codableTextViewJson: [String: Any] = ["backgroundColorHex": "#FF0000",
                                          "tintColorHex": "#00FF00",
                                          "isHidden": true,
                                          "isOpaque": false,
                                          "clipsToBounds": true,
                                          "alpha": 0.75,
                                          "cornerRadius": 8,
                                          "borderWidth": 1,
                                          "borderColorHex": "#FFFF00",
                                          "shadowColorHex": "#800080",
                                          "shadowRadius": 6,
                                          "shadowOpacity": 0.1,
                                          "font": codableAvenir,
                                          "textColor": "#0000FF",
                                          "lineHeightMultiplier": 0.8]

let codableButtonJson: [String: Any] = ["backgroundColorHex": "#FF0000",
                                        "tintColorHex": "#00FF00",
                                        "isHidden": true,
                                        "isOpaque": false,
                                        "clipsToBounds": true,
                                        "alpha": 0.75,
                                        "cornerRadius": 8,
                                        "borderWidth": 1,
                                        "borderColorHex": "#FFFF00",
                                        "shadowColorHex": "#800080",
                                        "shadowRadius": 6,
                                        "shadowOpacity": 0.1,
                                        "font": codableAvenir,
                                        "titleColor": "#0000FF",
                                        "titleShadowColor": "#0000FF"]

let codableAvenir: [String: Any] = ["name": "Avenir-Medium", "size": 18]
