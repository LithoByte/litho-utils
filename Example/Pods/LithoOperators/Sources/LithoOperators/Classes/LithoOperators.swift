//
//  LithoOperators.swift
//  LithoOperators
//
//  Created by Elliot Schrock on 10/12/19.
//

import Prelude

/**
 This operator is from the excellent PointFree videos, allowing you to compose a function `(A) -> B` with another function `(B) -> C` to create a new function `(A) -> C`. This is simply an overload of the operator to allow functions that do not take parameters to be the composed function, as well as functions that take multiple parameters to be the composing function.
 */

public func >>> <U, V> (f: @escaping () -> U, g: @escaping (U) -> V) -> () -> V {
    return { g(f()) }
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
infix operator <>=: AssignmentPrecedence
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
public func <>=<A>(f: inout ((A) -> Void), g: ((A) -> Void)?) {
    if let g = g {
        f = f <> g
    }
}
public func <>=<A, B>(f: inout ((A, B) -> Void), g: ((A, B) -> Void)?) {
    if let g = g {
        f = union(f, g)
    }
}
public func <>=<A>(f: inout ((A) -> Void)?, g: ((A) -> Void)?) {
    if let g = g {
        f = f == nil ? g : f! <> g
    }
}
public func <>=<A, B>(f: inout ((A, B) -> Void)?, g: ((A, B) -> Void)?) {
    if let g = g {
        f = f == nil ? g : union(f!, g)
    }
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
