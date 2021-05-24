//
//  CanIndicateActivityTests.swift
//  LithoUtils_Tests
//
//  Created by Calvin Collins on 5/21/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import LithoUtils

class CanIndicateActivityTests: XCTestCase {
    func testStartStop() {
        let indicator = UIActivityIndicatorView()
        let wrapper = ActivityWrapper(activityIndicatorView: indicator)
        wrapper.indicateActivity()
        XCTAssertTrue(indicator.isAnimating)
        XCTAssertFalse(indicator.isHidden)
        wrapper.activityFinished()
        XCTAssertFalse(indicator.isAnimating)
        XCTAssertTrue(indicator.isHidden)
    }
}

struct ActivityWrapper: CanIndicateActivity {
    var activityIndicatorView: UIActivityIndicatorView?
}
