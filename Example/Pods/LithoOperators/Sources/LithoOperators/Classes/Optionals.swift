//
//  Optionals.swift
//  LithoOperators
//
//  Created by Elliot Schrock on 6/23/21.
//

import Foundation
/**
 This function executes `f` if the value passed in is non-`nil`. Convenient when you have
 a function that accepts only non-optional values, but you have an unwrapped variable. Basically,
 this function unwraps optionals for you.
 */
public func ifExecute<T>(_ t: T?, _ f: (T) -> Void) {
    if let t = t {
        f(t)
    }
}
public func ifExecute<T, U>(_ t: T?, _ f: (T) -> U) -> U? {
    if let t = t {
        return f(t)
    }
    return nil
}
public func ifExecute<T, U>(_ t: T?, _ f: (T) -> U?) -> U? {
    if let t = t {
        return f(t)
    }
    return nil
}

// This is just an operator version of `ifExecute`.
infix operator ?>: MultiplicationPrecedence
public func ?><T, U>(t: T?, f: (T) -> U) -> U? {
    if let t = t {
        return f(t)
    }
    return nil
}
public func ?><T>(t: T?, f: (T) -> Void) {
    if let t = t {
        f(t)
    }
}

// function version of the nil coalescing operator `??`
public func coalesceNil<T>(with defaultValue: T) -> (T?) -> T {
    return { t in
        return t ?? defaultValue
    }
}

/**
 This is a really nice function that will cast objects for you. When paired with `>?>` the compiler will
 be able to tell what type to cast to without you saying explicitly.
 */

public func optionalCast<T, U>(object: T) -> U? {
    return object as? U
}
prefix operator ~>
public prefix func ~><T, U, V>(f: @escaping (U) -> V) -> (T) -> V? {
    return optionalCast >?> f
}
public prefix func ~><T, U>(f: @escaping (U) -> Void) -> (T) -> Void {
    return optionalCast >?> f
}
