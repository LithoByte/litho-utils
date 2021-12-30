//
//  OpenUrl.swift
//  LithoUtils
//
//  Created by Calvin Collins on 11/16/21.
//

import LithoOperators
import UIKit

public let openUrl = URL.init(string:) >?> (([:], nil) -**> UIApplication.shared.open)
