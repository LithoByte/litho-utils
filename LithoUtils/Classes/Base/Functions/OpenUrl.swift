//
//  OpenURL.swift
//  LithoUtils
//
//  Created by Calvin Collins on 11/16/21.
//

import Foundation
import LithoOperators
import UIKit

public let openUrl = URL.init(string:) >?> (([:], nil) -**> UIApplication.shared.open)
