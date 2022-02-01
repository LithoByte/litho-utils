//
//  UIImage+Resize.swift
//  LithoUtils
//
//  Created by Calvin Collins on 5/24/21.
//

import Foundation
import UIKit

public extension UIImage {
    func resizedProportionally(newHeight: CGFloat) -> UIImage? {
        return resizeImageProportionally(self, newHeight: newHeight)
    }
}

public func resizeImageProportionally(_ image: UIImage, newHeight: CGFloat) -> UIImage? {
    let scale = newHeight / image.size.height
    let newWidth = image.size.width * scale
    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
    image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage
}
