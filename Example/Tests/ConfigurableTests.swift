//
//  ConfigurableTests.swift
//  LithoUtils_Tests
//
//  Created by Calvin Collins on 5/21/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
import UIKit
@testable import LithoUtils

class ConfigurableTests: XCTestCase {
    func testConfigure() {
        let label = UILabel().configure({ $0.backgroundColor = .blue })
        XCTAssertEqual(label.backgroundColor, .blue)
    }
}
