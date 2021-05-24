//
//  BindViewModelTests.swift
//  LithoUtils_Tests
//
//  Created by Calvin Collins on 5/21/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Combine
import XCTest
@testable import LithoUtils

class BindViewModelTests: XCTestCase {
    var cancelBag: Set<AnyCancellable> = []
    func testButtonEnabled() {
        let subject = PassthroughSubject<Bool, Never>()
        let button = UIButton()
        button.isEnabled = false
        bindButtonEnabledToPublisher(button, publisher: subject.eraseToAnyPublisher(), cancelBag: &cancelBag)
        subject.send(true)
        XCTAssertTrue(button.isEnabled)
        subject.send(false)
        XCTAssertFalse(button.isEnabled)
    }
    
    func testActivityHidden() {
        let subject = PassthroughSubject<Bool, Never>()
        let activity = UIActivityIndicatorView()
        activity.isHidden = true
        bindActivityIndicatorVisibleToPublisher(activity, publisher: subject.eraseToAnyPublisher(), cancelBag: &cancelBag)
        subject.send(true)
        XCTAssertFalse(activity.isHidden)
        subject.send(false)
        XCTAssertTrue(activity.isHidden)
    }
    
    func testBind() {
        let subject = PassthroughSubject<Bool, Never>()
        let button = UIButton()
        button.isEnabled = true
        subject.bind(to: \UIButton.isEnabled, on: button, storingIn: &cancelBag)
        subject.send(false)
        XCTAssertFalse(button.isEnabled)
    }
}
