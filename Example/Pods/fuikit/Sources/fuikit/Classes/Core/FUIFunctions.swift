//
//  FUIFunctions.swift
//  fuikit
//
//  Created by Calvin Collins on 7/21/21.
//

import UIKit
import LithoOperators
import Prelude

public func addSubview(_ adder: UIView, subview: UIView) {
    adder.addSubview(subview)
}

public func addSublayer(_ adder: CALayer, sublayer: CALayer) {
    adder.addSublayer(sublayer)
}

public let setMask: (CALayer, CALayer) -> Void = setter(\CALayer.mask)

public func addGestureRecognizer(_ gesture: UIGestureRecognizer) -> (UIView) -> Void {
    return { view in
        view.addGestureRecognizer(gesture)
    }
}

public func addTarget(target: Any?, selector: Selector, event: UIControl.Event) -> (UIControl) -> Void {
    return { control in
        control.addTarget(target, action: selector, for: event)
    }
}

public func convert(view1: UIView, to view2: UIView) -> CGRect {
    return view1.convert(view1.bounds, to: view2)
}

public func convert(vc: UIViewController, to view: UIView) -> CGRect {
    return vc.view.convert(vc.view.bounds, to: view)
}

/**
 Returns a gradient layer with no frame
 - Parameter colors: The colors, from startPoint to endPoint *see below*
 - Parameter startPoint: A normalized point `(x:[0, 1], y: [0, 1])` marking  where `colors[0]` is drawn
 - Parameter endpoint: A normalized point `(x: [0, 1], y: [0, 1])` marking where `colors.last?` is drawn
 */
public func gradientLayer(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) -> CAGradientLayer {
    let layer = CAGradientLayer()
    layer.colors = colors.map(\.cgColor)
    layer.startPoint = startPoint
    layer.endPoint = endPoint
    return layer
}

public func withPadding(_ rect: CGRect, padding: CGFloat) -> CGRect {
    return rect.insetBy(dx: -padding, dy: -padding)
}

public let withPadding = curry(flip(withPadding(_:padding:)))

public func shiftRight(rect: CGRect, by shift: CGFloat) -> CGRect {
    return CGRect(x: rect.minX + shift, y: rect.minY, width: rect.width, height: rect.height)
}
public let shiftedRightBy = curry(flip(shiftRight))

public func shiftLeft(rect: CGRect, by shift: CGFloat) -> CGRect {
    return CGRect(x: rect.minX - shift, y: rect.minY, width: rect.width, height: rect.height)
}
public let shiftedLeftBy = curry(flip(shiftLeft))

public func shiftUp(rect: CGRect, by shift: CGFloat) -> CGRect {
    return CGRect(x: rect.minX, y: rect.minY - shift, width: rect.width, height: rect.height)
}
public let shiftedUpBy = curry(flip(shiftUp))

public func shiftDown(rect: CGRect, by shift: CGFloat) -> CGRect {
    return CGRect(x: rect.minX, y: rect.minY + shift, width: rect.width, height: rect.height)
}
public let shiftedDownBy = curry(flip(shiftDown))

public func shiftViewRight(by shift: CGFloat) -> (UIView) -> Void {
    return { view in
        view.frame = shiftRight(rect: view.frame, by: shift)
    }
}

public func shiftViewLeft(by shift: CGFloat) -> (UIView) -> Void {
    return { view in
        view.frame = shiftLeft(rect: view.frame, by: shift)
    }
}

public func shiftViewUp(by shift: CGFloat) -> (UIView) -> Void {
    return { view in
        view.frame = shiftUp(rect: view.frame, by: shift)
    }
}

public func shiftViewDown(by shift: CGFloat) -> (UIView) -> Void {
    return { view in
        view.frame = shiftDown(rect: view.frame, by: shift)
    }
}

/**
 Combines two rectangles into a box that contains both
 - Pre: Must be in the same coordinate space
 */

public func combineTwoRects(rect1: CGRect, rect2: CGRect) -> CGRect {
    let x = rect1.minX < rect2.minX ? rect1.minX : rect2.minX
    let y = rect1.minY < rect2.minY ? rect1.minY : rect2.minY
    let width = rect1.width > rect2.width ? rect1.width : rect2.width
    let height = rect1.height > rect2.height ? rect1.height : rect2.height
    return CGRect(x: x, y: y, width: width, height: height)
}

/**
 Combines an array of rectangles into a rectangle containing all elements
 - Parameter rects: [CGRect]
 */
public func combineRects(rects: CGRect...) -> CGRect {
    return rects.count == 0 ? .zero : rects.reduce(rects[0], combineTwoRects)
}

public func wheelsDatePicker(for textField: UITextField?, locale: Locale? = nil) -> UIDatePicker {
    let datePicker = UIDatePicker()
    textField?.inputView = datePicker
    if #available(iOS 13.4, *) {
        datePicker.preferredDatePickerStyle = .wheels
    }
    datePicker.datePickerMode = .date
    datePicker.locale = locale
    return datePicker
}
