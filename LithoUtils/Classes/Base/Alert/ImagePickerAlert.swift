//
//  ImagePickerAlert.swift
//  LithoUtils
//
//  Created by Calvin Collins on 12/3/21.
//

import Foundation
import fuikit
import LithoOperators

public func imagePickerAlert(vc: UIViewController, imagePicker: UIImagePickerController, title: String? = "How do you want to upload your picture?", message: String? = nil) -> UIAlertController {
    let alert = actionSheetPopoverSafe(title: title, message: message, sourceView: vc.view)
    alert.addAction(defaultAlertAction(title: "Camera", handler: ignoreArg({ [weak vc] in
        guard let vc = vc else { return }
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        }
        alert.dismissAnimated(imagePicker *> vc.presentClosure())
    })))
    alert.addAction(defaultAlertAction(title: "Library", handler: ignoreArg({ [weak vc] in
        guard let vc = vc else { return }
        imagePicker.sourceType = .photoLibrary
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alert.dismissAnimated(imagePicker *> vc.presentClosure())
        }
    })))
    alert.addAction(cancelAlertAction(title: "Cancel", handler: ignoreArg(nil *> alert.dismissClosure())))
    return alert
}
