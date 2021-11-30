//
//  ViewController.swift
//  LithoUtils
//
//  Created by cjc8@williams.edu on 05/17/2021.
//  Copyright (c) 2021 cjc8@williams.edu. All rights reserved.
//

import UIKit
import LithoUtils

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentSafeActionSheet))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presentAnimated(alertController(title: "hello", message: "hello"))
    }
    
    @objc func presentSafeActionSheet() {
        self.presentAnimated(actionSheetPopoverSafe(title: "hello", message: "Message", barButton: navigationItem.rightBarButtonItem!))
    }
}

