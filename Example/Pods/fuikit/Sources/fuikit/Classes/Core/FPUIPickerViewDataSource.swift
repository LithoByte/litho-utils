//
//  FPUIPickerViewDataSource.swift
//  fuikit
//
//  Created by Calvin Collins on 8/13/21.
//

import UIKit

public class FPUIPickerViewDataSource: NSObject, UIPickerViewDataSource {
    
    public var onNumberOfComponents: ((UIPickerView) -> Int)?
    public var onNumberOfRowsInComponent: ((UIPickerView, Int) -> Int)?
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return onNumberOfComponents?(pickerView) ?? 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return onNumberOfRowsInComponent?(pickerView, component) ?? 0
    }
}
