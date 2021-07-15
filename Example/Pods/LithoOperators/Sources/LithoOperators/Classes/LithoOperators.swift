//
//  LithoOperators.swift
//  LithoOperators
//
//  Created by Elliot Schrock on 10/12/19.
//

import Prelude

/**
 This operator is from the excellent PointFree videos, allowing you to compose a function `(A) -> B` with another function `(B) -> C` to create a new function `(A) -> C`. This is simply an overload of the operator to allow functions that do not take parameters to be the composed function.
 */

public func >>> <U, V> (f: @escaping () -> U, g: @escaping (U) -> V) -> () -> V {
    return { g(f()) }
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
 This operator allows you to pass a tuple of a function's argument types instead of
 manually decomposing the tuple's values. So, `f(a, b)` == `(~f)((a,b))`. This is useful when
 a function outputs a tuple that you want to pass to a regular function. So suppose `g`
 is a function from `(T) -> (A, B)`; then the following would not compile: `g >>> f` while the
 following would: `g >>> ~f`. NOTE: I haven't checked this recently, Swift may have added
 support for doing this without this operator.
 */
prefix operator ~
public prefix func ~<A, B, C>(f: @escaping (A, B) -> C) -> ((A, B)) -> C {
    return { (tuple: (A, B)) -> C in
        return f(tuple.0, tuple.1)
    }
}
public prefix func ~<A, B, C, D>(f: @escaping (A, B, C) -> D) -> ((A, B, C)) -> D {
    return { (tuple: (A, B, C)) -> D in
        return f(tuple.0, tuple.1, tuple.2)
    }
}
public prefix func ~<A, B, C>(f: @escaping ((A, B)) -> C) -> (A, B) -> C {
    return { a, b in
        f((a, b))
    }
}
public prefix func ~<A, B, C, D>(f: @escaping ((A, B, C)) -> D) -> (A, B, C) -> D {
    return { a, b, c in
        f((a, b, c))
    }
}

/**
 This is basically an operator version of `union`, see below.
 */
//TESTED
infix operator <>: AdditionPrecedence
public func <><A>(f: @escaping (A) -> Void, g: @escaping (A) -> Void) -> (A) -> Void {
    return { a in
        f(a)
        g(a)
    }
}

/**
 Operator version of `union`, although it tacks on the second function onto the first (similar to +=)
 */
infix operator <>=: AdditionPrecedence
public func <>=<A>(f: inout ((A) -> Void), g: @escaping (A) -> Void) {
    f = f <> g
}
public func <>=<A, B>(f: inout ((A, B) -> Void), g: @escaping (A, B) -> Void) {
    f = union(f, g)
}
public func <>=<A>(f: inout ((A) -> Void)?, g: @escaping (A) -> Void) {
    f = f == nil ? g : f! <> g
}
public func <>=<A, B>(f: inout ((A, B) -> Void)?, g: @escaping (A, B) -> Void) {
    f = f == nil ? g : union(f!, g)
}

//allows mutating A, as opposed to <>
infix operator <~>: AdditionPrecedence
public func <~><A>(f: @escaping (inout A) -> Void, g: @escaping (inout A) -> Void) -> (inout A) -> Void {
    return { a in
        f(&a)
        g(&a)
    }
}

//allows mutating A, as opposed to |>
infix operator />: ForwardApplication
public func /><A>(a: inout A, f: @escaping (inout A) -> Void) -> Void {
    f(&a)
}

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
