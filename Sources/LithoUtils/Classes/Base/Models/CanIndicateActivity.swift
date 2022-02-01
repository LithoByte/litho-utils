//
//  CanIndicateActivity.swift
//  LUX
//
//  Created by Elliot Schrock on 1/22/21.
//

import UIKit

public protocol CanIndicateActivity { var activityIndicatorView: UIActivityIndicatorView? { get } }
public extension CanIndicateActivity {
    func indicateActivity() {
        activityIndicatorView?.isHidden = false
        activityIndicatorView?.startAnimating()
    }
    func activityFinished() {
        activityIndicatorView?.isHidden = true
        activityIndicatorView?.stopAnimating()
    }
}
