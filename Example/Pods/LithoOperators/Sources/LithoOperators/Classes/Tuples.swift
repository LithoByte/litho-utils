//
//  Tuples.swift
//  LithoOperators
//
//  Created by Elliot Schrock on 6/23/21.
//

import Foundation

// Tuples!
public func first<A, B, C>(_ f: @escaping (A) -> C) -> ((A, B)) -> (C, B) {
    return { pair in
        return (f(pair.0), pair.1)
    }
}
public func second<A, B, C>(_ f: @escaping (B) -> C) -> ((A, B)) -> (A, C) {
    return { pair in
        return (pair.0, f(pair.1))
    }
}

/**
 This function takes in two functions that return Void, and creates a function that takes in the inputs for both functions and runs the functions on their respective input
 */

public func tupleUncurry<T, U>(_ f: @escaping (T) -> Void, _ g: @escaping (U) -> Void) -> (T, U) -> Void {
    return { t, u in
        f(t)
        g(u)
    }
}

public func tupleUncurry<T, U, V>(_ f: @escaping (T) -> Void, _ g: @escaping (U) -> Void, _ h: @escaping (V) -> Void) -> (T, U, V) -> Void {
    return { t, u, v in
        f(t)
        g(u)
        h(v)
    }
}

/**
 This version works similar to the above tupleMap but allows the input functions to have return values, creates a function that returns a tuple of those values (i.e. a mix between tupleMap and fzip)
 */
public func tupleMap<T, U, V, W>(_ f: @escaping (T) -> V, _ g: @escaping (U) -> W) -> (T, U) -> (V, W) {
    return { t, u in
        (f(t), g(u))
    }
}

public func tupleMap<T, U, V, W, X, Y>(_ f: @escaping (T) -> W, _ g: @escaping (U) -> X, _ h: @escaping (V) -> Y) -> (T, U, V) -> (W, X, Y) {
    return { t, u, v in
        (f(t), g(u), h(v))
    }
}
