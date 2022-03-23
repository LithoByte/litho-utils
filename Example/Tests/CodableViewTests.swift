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
