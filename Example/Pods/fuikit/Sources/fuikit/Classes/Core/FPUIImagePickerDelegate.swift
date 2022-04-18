//
//  FUIImagePickerDelegate.swift
//  fuikit
//
//  Created by Calvin Collins on 3/16/21.
//

import Foundation
import UIKit
import Photos

open class FPUIImagePickerDelegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    open var onPickerDidCancel: ((UIImagePickerController) -> Void)?
    open var onPickerDidPick: ((UIImagePickerController, [UIImagePickerController.InfoKey : Any]) -> Void)?
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        onPickerDidCancel?(picker)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        onPickerDidPick?(picker, info)
    }
}

public let infoToMediaURL: ([UIImagePickerController.InfoKey : Any]) -> URL?
    = { $0[UIImagePickerController.InfoKey.mediaURL] as? URL }
public let infoToOriginalImage: ([UIImagePickerController.InfoKey : Any]) -> UIImage?
    = { $0[UIImagePickerController.InfoKey.originalImage] as? UIImage }
public let infoToEditedImage: ([UIImagePickerController.InfoKey : Any]) -> UIImage?
    = { $0[UIImagePickerController.InfoKey.editedImage] as? UIImage }
public let infoToCropRect: ([UIImagePickerController.InfoKey : Any]) -> CGRect?
    = { $0[UIImagePickerController.InfoKey.cropRect] as? CGRect }
public let infoToImageURL: ([UIImagePickerController.InfoKey : Any]) -> URL?
    = { $0[UIImagePickerController.InfoKey.imageURL] as? URL }
public let infoToLivePhoto: ([UIImagePickerController.InfoKey : Any]) -> PHLivePhoto?
    = { $0[UIImagePickerController.InfoKey.livePhoto] as? PHLivePhoto }
public let infoToMediaMetadata: ([UIImagePickerController.InfoKey : Any]) -> NSDictionary?
    = { $0[UIImagePickerController.InfoKey.mediaMetadata] as? NSDictionary }
