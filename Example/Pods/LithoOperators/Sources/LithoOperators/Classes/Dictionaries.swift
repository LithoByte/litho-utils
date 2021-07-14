//
//  Dictionaries.swift
//  LithoOperators
//
//  Created by Elliot Schrock on 6/23/21.
//

import Foundation

public prefix func ^<Key, Value>(_ dict: [Key:Value]) -> (Key) -> Value? {
    return { key in
        dict[key]
    }
}

public extension Dictionary {
    var keyToValue: (Key) -> (Value?) {
        return { key in
            self[key]
        }
    }
}

public func get<T>(index: Int, array: [T]) -> T? {
    return index < array.count ? array[index] : nil
}

public func keyToValue<T, U>(for dict: [T:U]) -> (T) -> U? {
    return { t in
        dict[t]
    }
}

public func index<T>(array: [T]) -> (Int) -> T? {
    return array -*> get
}
