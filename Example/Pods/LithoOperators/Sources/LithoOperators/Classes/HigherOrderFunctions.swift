//
//  HigherOrderFunctions.swift
//  LithoOperators
//
//  Created by Elliot on 1/6/22.
//

import Foundation

//higher order functions

/**
 Here, `union` will take a bunch of functions and return a function that, when called, will
 call each of those functions in the bunch. I use this mostly for UI styling, so for instance,
 for two functions called `setClipsToBounds` and `setGrayBackground` both of
 which are from `UIView -> Void`, then you could create a new function called, say,
 `clipAndGrayBg = union(setClipsToBounds, setGrayBackground)`.
 */

//TESTED
public func union(_ functions: (() -> Void)...) -> () -> Void {
    return {
        for f in functions {
            f()
        }
    }
}

public func union<T>(_ functions: ((T) -> Void)...) -> (T) -> Void {
    return { (t: T) in
        for f in functions {
            f(t)
        }
    }
}

public func union<T, U>(_ functions: ((T, U) -> Void)...) -> (T, U) -> Void {
    return { (t: T, u: U) in
        for f in functions {
            f(t, u)
        }
    }
}

public func union<T, U, V>(_ functions: ((T, U, V) -> Void)...) -> (T, U, V) -> Void {
    return { (t: T, u: U, v: V) in
        for f in functions {
            f(t, u, v)
        }
    }
}

public func returnValue<T>(_ value: T) -> () -> T {
    return { return value }
}

/**
 This function always executes f. Convenient when you have a function that returns a void function and you want to execute the function
 */
public func execute(_ f: @escaping () -> Void) {
    f()
}
public func execute<T>(_ f: @escaping () -> T) -> T {
    return f()
}
public func execute<A, B>(_ f: @escaping () -> (A) -> B) -> (A) -> B {
    return f()
}

public func ifThenCall(_ condition: Bool, _ f: @escaping () -> Void, else g: (() -> Void)? = nil) {
    if condition {
        f()
    } else {
        g?()
    }
}

public func ifThen(_ condition: @escaping () -> Bool, _ f: @escaping () -> Void, else g: (() -> Void)? = nil) -> () -> Void {
    return {
        if condition() {
            f()
        } else {
            g?()
        }
    }
}

public func ifThen<T>(_ condition: @escaping () -> Bool, _ f: @escaping (T) -> Void, else g: (() -> Void)? = nil) -> (T) -> Void {
    return { t in
        if condition() {
            f(t)
        } else {
            g?()
        }
    }
}

public func ifThen(_ condition: Bool, _ f: @escaping () -> Void, else g: (() -> Void)? = nil) -> () -> Void {
    return {
        if condition {
            f()
        } else {
            g?()
        }
    }
}

public func ifThen<T>(_ condition: Bool, _ f: @escaping (T) -> Void, else g: (() -> Void)? = nil) -> (T) -> Void {
    return { t in
        if condition {
            f(t)
        } else {
            g?()
        }
    }
}

public func ifThen<T>(_ condition: @escaping (T) -> Bool, _ f: @escaping () -> Void, else g: (() -> Void)? = nil) -> (T) -> Void {
    return { t in
        if condition(t) {
            f()
        } else {
            g?()
        }
    }
}

public func ifThen<T, U>(_ condition: @escaping (T) -> Bool, _ f: @escaping (T) -> U) -> (T) -> (U?) {
    return { t in
        condition(t) ? f(t) : nil
    }
}

/**
 This function passes itself to the given function if the condition is true. I don't use it much in iOS, but
 it's pretty helpful in Vapor when creating database queries.
 */
public protocol ConditionalApply {}
extension ConditionalApply {
    public func ifApply(_ condition: Bool, _ function: (Self) -> Self) -> Self {
        if condition {
            return function(self)
        } else {
            return self
        }
    }
}

//other functions

/**
 This function zips together the outputs of functions into a tuple. Very convenient when creating a view from a single model while
 keeping the two decoupled.
 */

public func fzip<T, U, V>(_ f: @escaping (T) -> U, _ g: @escaping (T) -> V) -> (T) -> (U, V) {
    return { t in
        return (f(t), g(t))
    }
}
public func fzip<T, U, V, W>(_ f: @escaping (T) -> U, _ g: @escaping (T) -> V, _ h: @escaping (T) -> W) -> (T) -> (U, V, W) {
    return { t in
        return (f(t), g(t), h(t))
    }
}
public func fzip<T, U, V, W, X>(_ f: @escaping (T) -> U, _ g: @escaping (T) -> V, _ h: @escaping (T) -> W, _ j: @escaping (T) -> X) -> (T) -> (U, V, W, X) {
    return { t in
        return (f(t), g(t), h(t), j(t))
    }
}
public func fzip<T, U, V, W, X, Y>(_ f: @escaping (T) -> U, _ g: @escaping (T) -> V, _ h: @escaping (T) -> W, _ j: @escaping (T) -> X, _ k: @escaping (T) -> Y) -> (T) -> (U, V, W, X, Y) {
    return { t in
        return (f(t), g(t), h(t), j(t), k(t))
    }
}
public func fzip<T, U, V, W, X, Y, Z>(_ f: @escaping (T) -> U, _ g: @escaping (T) -> V, _ h: @escaping (T) -> W, _ j: @escaping (T) -> X, _ k: @escaping (T) -> Y, _ l: @escaping (T) -> Z) -> (T) -> (U, V, W, X, Y, Z) {
    return { t in
        return (f(t), g(t), h(t), j(t), k(t), l(t))
    }
}

// The returned function executes the argument and returns the input; great
// for when you just want to do something when a value is published in
// Combine
public func id<T>(with sideEffect: @escaping () -> Void) -> (T) -> (T) {
    return {
        sideEffect()
        return $0
    }
}
public func id<T>(with sideEffect: @escaping (T) -> Void) -> (T) -> (T) {
    return {
        sideEffect($0)
        return $0
    }
}
