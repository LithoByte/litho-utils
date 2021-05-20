//
//  iOSFunctions.swift
//  LUX
//
//  Created by Elliot Schrock on 12/4/20.
//

import Foundation
import LithoOperators
import Prelude

public func ifSimulator(f: () -> Void) {
    #if targetEnvironment(simulator)
    f()
    #else
    return
    #endif
}

public func ifSimulator<T>(f: @escaping (T) -> Void) -> (T) -> Void {
    #if targetEnvironment(simulator)
    return f
    #else
    return { _ in }
    #endif
}

public func isSimulator() -> Bool {
    #if targetEnvironment(simulator)
        return true
    #else
        return false
    #endif
}

public func isDevice() -> Bool {
    return !isSimulator()
}

public func ifDevice(f: () -> Void) {
    #if targetEnvironment(simulator)
    return
    #else
    return f()
    #endif
}

public func ifDevice<T>(f: @escaping (T) -> Void) -> (T) -> Void {
    #if targetEnvironment(simulator)
    return { _ in }
    #else
    return f
    #endif
}

public func iOS13AndAbove() -> Bool {
    if #available(iOS 13.0, *) {
        return true
    } else {
        return false
    }
}

public let iOS12OrBelow: () -> Bool = iOS13AndAbove >>> { !$0 }

public func iOS13AndAbove(_ f: @escaping () -> Void) {
    if (iOS13AndAbove()) {
        f()
    }
}

public func iOS12OrBelow(_ f: @escaping () -> Void) {
    if (iOS12OrBelow()) {
        f()
    }
}

public func iOS13AndAbove(_ f: @escaping (Bool) -> Void) {
    f(iOS13AndAbove())
}

public func runOnMain(_ f: @escaping () -> Void) -> () -> Void {
    return {
        DispatchQueue.main.async {
            f()
        }
    }
}

public func runOnMain<T>(_ f: @escaping (T) -> Void) -> (T) -> Void {
    return { t in
        DispatchQueue.main.async {
            f(t)
        }
    }
}

public func runOnMain<T, U>(_ f: @escaping (T, U) -> Void) -> (T, U) -> Void {
    return { t, u in
        DispatchQueue.main.async {
            f(t, u)
        }
    }
}

public func runOnMain<T, U, V>(_ f: @escaping (T, U, V) -> Void) -> (T, U, V) -> Void {
    return { t, u, v in
        DispatchQueue.main.async {
            f(t, u, v)
        }
    }
}
