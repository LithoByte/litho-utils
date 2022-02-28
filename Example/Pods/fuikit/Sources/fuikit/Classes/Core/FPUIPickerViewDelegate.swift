//
//  FPUIPickerViewDelegate.swift
//  fuikit
//
//  Created by Calvin Collins on 8/13/21.
//

import UIKit

public class FPUIPickerViewDelegate: NSObject, UIPickerViewDelegate {
    public var onRowHeightForComponent: ((UIPickerView, Int) -> CGFloat)?
    public var onWidthForComponent: ((UIPickerView, Int) -> CGFloat)?
    public var onTitleForRowAtComponent: ((UIPickerView, Int, Int) -> String?)?
    public var onAttributedTitleForRowAtComponent: ((UIPickerView, Int, Int) -> NSAttributedString?)?
    public var onViewForRowAtComponent: ((UIPickerView, Int, Int, UIView?) -> UIView)?
    public var onDidSelectRowInComponent: ((UIPickerView, Int, Int) -> Void)?
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return onRowHeightForComponent?(pickerView, component) ?? 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return onWidthForComponent?(pickerView, component) ?? 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return onTitleForRowAtComponent?(pickerView, row, component)
    }
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return onAttributedTitleForRowAtComponent?(pickerView, row, component)
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return onViewForRowAtComponent?(pickerView, row, component, view) ?? UIView()
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        onDidSelectRowInComponent?(pickerView, row, component)
    }
}
