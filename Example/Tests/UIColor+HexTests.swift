//
//  UIColor+HexTests.swift
//  LithoUtils_Tests
//
//  Created by Calvin Collins on 5/21/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import LithoUtils

class UIColor_HexTests: XCTestCase {

    func testUIColorHex() {
        let color1 = UIColor(hex: 0x000000)
        let color2 = UIColor.uicolorFromHex(rgbValue: 0x000000)
        XCTAssert(color1 == color2)
    }

    func testUIColorStringHexLengthSix() {
        let color1 = UIColor(hex: 0xFFF000)
        let color2 = UIColor(hexString: "#FFF000")
        let color3 = UIColor(hexString: "FFF000")
        XCTAssertEqual(color1, color2)
        XCTAssertEqual(color1, color3)
    }
    
    func testUIColorStringHexLengthThree() {
        let color1 = UIColor(hex: 0xFF0011)
        let color2 = UIColor(hexString: "#F01")
        let color3 = UIColor(hexString: "F01")
        XCTAssertEqual(color1, color2)
        XCTAssertEqual(color1, color3)
    }
    
    func testUIColorStringHexLengthFour() {
        let color1 = UIColor(hex: 0xFF0011).withAlphaComponent(1.0)
        let color2 = UIColor(hexString: "#F01F")
        let color3 = UIColor(hexString: "F01F")
        XCTAssertEqual(color1, color2)
        XCTAssertEqual(color1, color3)
    }
    
    func testUIColorStringHexLengthEight() {
        let color1 = UIColor(hex: 0xFFF000).withAlphaComponent(1.0)
        let color2 = UIColor(hexString: "#FFF000FF")
        let color3 = UIColor(hexString: "FFF000FF")
        XCTAssertEqual(color1, color2)
        XCTAssertEqual(color1, color3)
    }
    
    func testUIColorStringHexBadInput() {
        let color1 = UIColor(hexString: "#000000FF")
        let color2 = UIColor(hexString: "#F13f3")
        XCTAssertEqual(color1, color2)
    }
}
