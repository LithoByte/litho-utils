//
//  Optionals.swift
//  LithoOperators
//
//  Created by Elliot Schrock on 6/23/21.
//

import Foundation
import Prelude

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

/**
 This operator allows you to chain functions where optionality is an issue. For instance,
 suppose you had a function `f` which output a `String?` and another function `g` which only
 accepts a `String`; trying to use `f >>> g` would fail to compile, since you can't pass `nil`
 to `g`. By using `f >?> g`, however, will compile, since this operator only executes `g` if
 `f` returns a non-`nil` value. This is really nice paired with `optionalCast` defined below,
 which will try to cast an object for you. So for instance, suppose you had a function `f` from
 `(UIButton) -> Void` but wanted to be able to apply it intelligently to any `UIView` passed
 in; then you could do `optionalCast >?> f` and the compiler would return a function from
 `UIView -> Void` which, if the UIView is a `UIButton` in particular, would apply `f` to it.
 */

//TESTED
infix operator >?>: Composition
public func >?><A, B, C>(f: @escaping (A) -> B?, g: @escaping (B) -> C) -> (A) -> C? {
    return { a in
        if let b = f(a) {
            return g(b)
        } else {
            return nil
        }
    }
}
public func >?><A, B, C>(f: @escaping (A) -> B?, g: ((B) -> C)?) -> (A) -> C? {
    return { a in
        if let b = f(a) {
            return g?(b)
        } else {
            return nil
        }
    }
}
public func >?><A, B, C>(f: @escaping (A) -> B?, g: @escaping (B) -> C?) -> (A) -> C? {
    return { a in
        if let b = f(a) {
            return g(b)
        } else {
            return nil
        }
    }
}
public func >?><A, B, C, D>(f: @escaping (A, B) -> C?, g: @escaping (C) -> D) -> (A, B) -> D? {
    return { a, b in
        if let c = f(a, b) {
            return g(c)
        } else {
            return nil
        }
    }
}
public func >?><A, B, C, D>(f: @escaping (A, B) -> C?, g: @escaping (C) -> D?) -> (A, B) -> D? {
    return { a, b in
        if let c = f(a, b) {
            return g(c)
        } else {
            return nil
        }
    }
}
public func >?><A, B>(f: @escaping (A) -> B?, g: @escaping (B) -> Void) -> (A) -> Void {
    return { a in
        if let b = f(a) {
            g(b)
        }
    }
}
public func >?><A, B>(f: @escaping (A) -> B?, g: ((B) -> Void)?) -> (A) -> Void {
    return { a in
        if let b = f(a) {
            g?(b)
        }
    }
}
public func >?><A, B, C>(f: @escaping (A, B) -> C?, g: @escaping (C) -> Void) -> (A, B) -> Void {
    return { a, b in
        if let c = f(a, b) {
            g(c)
        }
    }
}
public func >?><A, B, C, D>(f: @escaping (A, B, C) -> D?, g: @escaping (D) -> Void) -> (A, B, C) -> Void {
    return { a, b, c in
        if let d = f(a, b, c) {
            g(d)
        }
    }
}

/**
 These operators \have a subsitition effect on functions, instead of a currying effect. This allows you to take a function, say g: (Int, Int) -> Int, and use another function f: (String) -> Int?, and substitute f into g to make g': (String, Int) -> Int?.
 */
infix operator >?->: AdditionPrecedence
public func >?-><A, B, C, D>(f: @escaping (A) -> B?, g: @escaping (B, C) -> D) -> (A, C) -> D? {
    return { a, c in
        if let b = f(a) {
            return g(b, c)
        }
        return nil
    }
}
infix operator >?-->: AdditionPrecedence
public func >?--><A, B, C, D, E>(f: @escaping (A) -> B?, g: @escaping (B, C, D) -> E) -> (A, C, D) -> E? {
    return { a, c, d in
        if let b = f(a) {
            return g(b, c, d)
        }
        return nil
    }
}
infix operator >-?>: AdditionPrecedence
public func >-?><A, B, C, D>(f: @escaping (A) -> C?, g: @escaping (B, C) -> D) -> (B, A) -> D? {
    return { b, a in
        if let c = f(a) {
            return g(b, c)
        }
        return nil
    }
}
infix operator >-?->: AdditionPrecedence
public func >-?-><A, B, C, D, E>(f: @escaping (A) -> C?, g: @escaping (B, C, D) -> E) -> (B, A, D) -> E? {
    return { b, a, d in
        if let c = f(a) {
            return g(b, c, d)
        }
        return nil
    }
}
infix operator >--?>: AdditionPrecedence
public func >--?><A, B, C, D, E>(f: @escaping (A) -> D?, g: @escaping (B, C, D) -> E) -> (B, C, A) -> E? {
    return { b, c, a in
        if let d = f(a) {
            return g(b, c, d)
        }
        return nil
    }
}

public func >?-><A, B, C>(f: @escaping (A) -> B?, g: @escaping (B, C) -> Void) -> (A, C) -> Void {
    return { a, c in
        if let b = f(a) {
            return g(b, c)
        }
    }
}
public func >?--><A, B, C, D>(f: @escaping (A) -> B?, g: @escaping (B, C, D) -> Void) -> (A, C, D) -> Void {
    return { a, c, d in
        if let b = f(a) {
            return g(b, c, d)
        }
    }
}
public func >-?><A, B, C>(f: @escaping (A) -> C?, g: @escaping (B, C) -> Void) -> (B, A) -> Void {
    return { b, a in
        if let c = f(a) {
            return g(b, c)
        }
    }
}
public func >-?-><A, B, C, D>(f: @escaping (A) -> C?, g: @escaping (B, C, D) -> Void) -> (B, A, D) -> Void {
    return { b, a, d in
        if let c = f(a) {
            return g(b, c, d)
        }
    }
}
public func >--?><A, B, C, D>(f: @escaping (A) -> D?, g: @escaping (B, C, D) -> Void) -> (B, C, A) -> Void {
    return { b, c, a in
        if let d = f(a) {
            return g(b, c, d)
        }
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

public func isNotNil<T>(_ value: T?) -> Bool {
    return value != nil
}

public func allNotNil<T>(_ list: [T?]) -> Bool {
    return list |> allSatisfy(f: isNotNil(_:))
}

public func someNotNil<T>(_ list: [T?]) -> Bool {
    return list |> someSatisfy(f: isNotNil)
}
