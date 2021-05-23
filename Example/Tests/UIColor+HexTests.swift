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

}
