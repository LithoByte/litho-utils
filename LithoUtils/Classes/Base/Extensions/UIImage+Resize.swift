//
//  UIImage+Resize.swift
//  LithoUtils
//
//  Created by Calvin Collins on 5/24/21.
//

import Foundation

public extension UIImage {
    func resizedProportionally(newHeight: CGFloat) -> UIImage? {
        return resizeImage(self, newHeight: newHeight)
    }
}

public func resizeImage(_ image: UIImage, newHeight: CGFloat, proportionally: Bool = true) -> UIImage? {
    var newWidth = newHeight
    if proportionally {
        let scale = newHeight / image.size.height
        newWidth = image.size.width * scale
    }
    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
    image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage
}
