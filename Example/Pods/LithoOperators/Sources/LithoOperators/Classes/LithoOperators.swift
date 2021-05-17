//
//  LithoOperators.swift
//  LithoOperators
//
//  Created by Elliot Schrock on 10/12/19.
//

import Prelude

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
public func >?><A, B, C>(f: @escaping (A) -> B?, g: @escaping (B) -> C?) -> (A) -> C? {
    return { a in
        if let b = f(a) {
            return g(b)
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

/**
 This is basically an operator for currying. It puts the value `a` into the first postion of a function `f`
 from `(A, B) -> C` and returns a function that just accepts a value for `B`. In Prelude this would
 be `a |> curry(f)`.
 */
//TESTED
infix operator >|>: AdditionPrecedence
public func >|><A, B, C>(a: A, f: @escaping (A, B) -> C) -> (B) -> C {
    return { b in f(a, b) }
}
// TESTED
public func >|><A, B, C, D>(tuple: (A, B), f: @escaping (A, B, C) -> D) -> (C) -> D {
    return { c in f(tuple.0, tuple.1, c) }
}
public func >|><A, B, C, D>(a: A, f: @escaping (A, B, C) -> D) -> (B, C) -> D {
    return { b, c in f(a, b, c) }
}

/**
 Similar to `>|>`, but with the second value. So consider `f: (A, B) -> C`. Then `b >||> f`
 will put `b` into the second argument of `f` and return a function from `A -> C`. I find this more
 ergonmic than using `curry` in this case, since I don't need to swap the arguments around or anything.
 The use case for this is mostly with the free `map` function defined below, so for instance, if you had
 a function `f` from `Int -> String` and wanted to use it to change an array of `Int`s to `String`s,
 you could do so by saying: `f >||> map` which would return a function from `[Int] -> [String]`
 */
//TESTED
infix operator >||>: AdditionPrecedence
public func >||><A, B, C>(b: B, f: @escaping (A, B) -> C) -> (A) -> C {
    return { a in f(a, b) }
}
public func >||><A, B, C, D>(tuple: (B, C), f: @escaping (A, B, C) -> D) -> (A) -> D {
    return { a in f(a, tuple.0, tuple.1) }
}
public func >||><A, B, C, D, E>(tuple: (B, C, D), f: @escaping (A, B, C, D) -> E) -> (A) -> E {
    return { a in f(a, tuple.0, tuple.1, tuple.2) }
}

//Similar to the above two, but with more arguments...
// TESTED
infix operator >|||>: AdditionPrecedence
public func >|||><A, B, C, D>(c: C, f: @escaping (A, B, C) -> D) -> (A, B) -> D {
    return { a, b in f(a, b, c) }
}
public func >|||><A, B, C, D, E>(tuple: (C, D), f: @escaping (A, B, C, D) -> E) -> (A, B) -> E {
    return { a, b in f(a, b, tuple.0, tuple.1) }
}

//...and so on.
// TESTED
infix operator >||||>: AdditionPrecedence
public func >||||><A, B, C, D, E>(d: D, f: @escaping (A, B, C, D) -> E) -> (A, B, C) -> E {
    return { a, b, c in f(a, b, c, d) }
}

//...and so on...
// TESTED
infix operator >|||||>: AdditionPrecedence
public func >|||||><A, B, C, D, E, F>(e: E, f: @escaping (A, B, C, D, E) -> F) -> (A, B, C, D) -> F {
    return { a, b, c, d in f(a, b, c, d, e) }
}

//...and so on.
// TESTED
infix operator >||||||>: AdditionPrecedence
public func >||||||><A, B, C, D, E, F, G>(eff: F, f: @escaping (A, B, C, D, E, F) -> G) -> (A, B, C, D, E) -> G {
    return { a, b, c, d, e in f(a, b, c, d, e, eff) }
}

/**
 These operators can also have a subsitition effect on functions, instead of a currying effect. This allows you to take a function, say g: (Int, Int) -> Int, and use another function f: (String) -> Int, and substitute f into g to make g': (String, Int) -> Int. Note that the one parameter case is achieved by the >>> operator.
 */
infix operator >*>: AdditionPrecedence
public func >*><A, B, C, D>(f: @escaping (A) -> B, g: @escaping (B, C) -> D) -> (A, C) -> D {
    return uncurry(f >>> curry(g))
}
public func >*><A, B, C, D, E>(f: @escaping (A) -> B, g: @escaping (B, C, D) -> E) -> (A, C, D) -> E {
    return uncurry(f >>> curry(g))
}
infix operator >**>: AdditionPrecedence
public func >**><A, B, C, D>(f: @escaping (A) -> C, g: @escaping (B, C) -> D) -> (B, A) -> D {
    return flip(uncurry(f >>> curry(flip(g))))
}
public func >**><A, B, C, D, E>(f: @escaping (A) -> C, g: @escaping (B, C, D) -> E) -> (B, A, D) -> E {
    return shiftRight(uncurry(f >>> curry(shiftLeft(g))))
}
infix operator >***>: AdditionPrecedence
public func >***><A, B, C, D, E>(f: @escaping (A) -> D, g: @escaping (B, C, D) -> E) -> (B, C, A) -> E {
    return flip(uncurry(f >>> curry(flip(g))))
}

/**
 Mainly a helper function for these operators, but also useful if there's some currying operation you want to accomplish that isn't encompassed with the overloads we provide.
 */
public func shiftLeft<A, B, C, D>(_ f: @escaping (A, B, C) -> D) -> (B, C, A) -> D {
    return { b, c, a in
        f(a, b, c)
    }
}

public func shiftRight<A, B, C, D>(_ f: @escaping (A, B, C) -> D) -> (C, A, B) -> D {
    return { c, a, b in
        f(a, b, c)
    }
}


/**
 These sets of operators have the same semantics as the previous, only they take two functions. The latter is the function to curry, and the former returns a value to be curried into the latter. This is the technical equivalent of using >>> (see below) to compose f with g >||> (>|||>) if we want the returned value to be curried into the third position. Using operators on operators seems a little unreadable, however, so we overload these functions.
 */
public func >*><A, B, C>(f: @escaping () -> A, g: @escaping (A, B) -> C) -> (B) -> C {
    return (f |> execute) >|> g
}
public func >**><A, B, C>(f: @escaping () -> B, g: @escaping (A, B) -> C) -> (A) -> C {
    return (f |> execute) >||> g
}
public func >***><A, B, C, D>(f: @escaping () -> C, g: @escaping (A, B, C) -> D) -> (A, B) -> D {
    return (f |> execute) >|||> g
}

/**
 An operator to create a function that, given a keypath for a type, will a function that will accept
 an object of that type and return the object's property's value. So for instance,
 `^\UIViewController.view` will return a function `(UIViewController) -> UIView`
 */
prefix operator ^
public prefix func ^ <Root, Value>(kp: KeyPath<Root, Value>) -> (Root) -> Value {
  return get(kp)
}
public prefix func ^ <Root, Value>(kp: WritableKeyPath<Root, Value>)
  -> (@escaping (Value) -> Value)
  -> (Root) -> Root {

    return prop(kp)
}
public prefix func ^ <Root, Value>(_ kp: WritableKeyPath<Root, Value>)
  -> (@escaping (inout Value) -> Void)
    -> (inout Root) -> Void {

    return { update in
      { root in
        update(&root[keyPath: kp])
      }
    }
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

/**
 This just returns a function that can be called without arguments at a later time with the passed in value
 prepopulated. I often use this when a reusable component shouldn't know the passed in type, but needs
 to pass it to other code when an action occurs.
 */
//TESTED
public func voidCurry<T, U>(_ t: T, _ f: @escaping (T) -> U) -> () -> U {
    return { f(t) }
}

// Operator version of `voidCurry`
//TESTED
infix operator *>: MultiplicationPrecedence
public func *><T, U>(t: T, f: @escaping (T) -> U) -> () -> U {
    return { return f(t) }
}

/**
 Sometimes you don't care about the second argument of a function. I use this, for instance, in
 functional versions of `UIViewController`, where I have a function `f` from
 `UIViewController -> Void` that I want to pass into a property called
 `onViewDidAppear: (UIViewController, Bool) -> Void` which is a function I call in
 `viewDidAppear`. The `Bool` is just whether the appearance was animated or not;
 `f` doesn't care if it was animated, it only cares about the controller, so I could say:
 `vc.onViewDidAppear = ignoreSecondArg(f)`
 */
public func ignoreSecondArg<T, U, V>(f: @escaping (T) -> V) -> (T, U) -> V {
    return { t, _ in
        return f(t)
    }
}

/** 
 See ignoreSecondArg above. Similar functionality except ignore the first argument of a function instead
 of the second.
*/
public func ignoreFirstArg<T,U,V>(f: @escaping (U) -> V) -> (T,U) -> V {
    return { _, u in
        return f(u)
    }
}

public func ignoreArg<T, U>(_ f: @escaping () -> U) -> (T) -> U {
    return { _ in return f() }
}

public func ignoreArgs<T, U, Z>(_ f: @escaping () -> Z) -> (T, U) -> Z {
    return { _, _ in return f() }
}
public func ignoreArgs<T, U, V, Z>(_ f: @escaping () -> Z) -> (T, U, V) -> Z {
    return { _, _, _ in return f() }
}
public func ignoreArgs<T, U, V, W, Z>(_ f: @escaping () -> Z) -> (T, U, V, W) -> Z {
    return { _, _, _, _ in return f() }
}
public func ignoreArgs<T, U, V, W, X, Z>(_ f: @escaping () -> Z) -> (T, U, V, W, X) -> Z {
    return { _, _, _, _, _ in return f() }
}
public func ignoreArgs<T, U, V, W, X, Y, Z>(_ f: @escaping () -> Z) -> (T, U, V, W, X, Y) -> Z {
    return { _, _, _, _, _, _ in return f() }
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

// returns the first element of an array if it exists
// TESTED
public func firstElement<T>(_ array: [T]) -> T? {
    return array.first
}

// A free function version of `map`.
// TESTED
public func map<U, V>(array: [U], f: (U) -> V) -> [V] {
    return array.map(f)
}
public func map<U, V>(f: @escaping (U) -> V) -> ([U]) -> [V] {
    return {
        $0.map(f)
    }
}

// A free function version of `forEach`.
// TESTED
public func forEach<T>(array: [T], f: (T) -> Void) -> Void {
    return array.forEach(f)
}
public func forEach<T>(f: @escaping (T) -> Void) -> ([T]) -> Void {
    return {
        $0.forEach(f)
    }
}

// A free function version of `filter`.
// TESTED
public func filter<T>(array: [T], f: (T) -> Bool) -> [T] {
    return array.filter(f)
}
public func filter<T>(f: @escaping (T) -> Bool) -> ([T]) -> [T] {
    return {
        $0.filter(f)
    }
}

// A free function version of `compactMap`.
// TESTED
public func compactMap<U, V>(array: [U], f: (U) -> V?) -> [V] {
    return array.compactMap(f)
}
public func compactMap<U, V>(f: @escaping (U) -> V?) -> ([U]) -> [V] {
    return {
        $0.compactMap(f)
    }
}

// Allows you to transform arrays using keypaths
//TESTED
public extension Sequence {
    func map<Value>(_ kp: KeyPath<Element, Value>) -> [Value] {
        return self.map { $0[keyPath: kp] }
    }

    func compactMap<Value>(_ kp: KeyPath<Element, Value?>) -> [Value] {
        return self.compactMap { $0[keyPath: kp] }
    }
    
    func sortedBy<T>(keyPath: KeyPath<Element, T>) -> [Element] where T: Comparable {
        return self.sorted(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })
    }
    
    func sortedBy<T>(keyPath: KeyPath<Element, T?>, defaultValue: T) -> [Element] where T: Comparable {
        return self.sorted(by: { $0[keyPath: keyPath] ?? defaultValue < $1[keyPath: keyPath] ?? defaultValue })
    }
}

// free function version of `map` with keypaths.
//TESTED
public func map<Element, Value>(array: [Element], _ kp: KeyPath<Element, Value>) -> [Value] {
    return array.map(kp)
}
public func map<Element, Value>(_ kp: KeyPath<Element, Value>) -> ([Element]) -> [Value] {
    return {
        $0.map(kp)
    }
}

// free function version of `compactMap` with keypaths.
//TESTED
public func compactMap<Element, Value>(array: [Element], _ kp: KeyPath<Element, Value?>) -> [Value] {
    return array.compactMap(kp)
}
public func compactMap<Element, Value>(_ kp: KeyPath<Element, Value?>) -> ([Element]) -> [Value] {
    return {
        $0.compactMap(kp)
    }
}

public func sortedBy<Element, Property>(keyPath: KeyPath<Element, Property>) -> ([Element]) -> [Element] where Property: Comparable {
    return { $0.sortedBy(keyPath: keyPath) }
}

public func sortedBy<Element, Property>(keyPath: KeyPath<Element, Property?>, defaultValue: Property)
-> ([Element]) -> [Element] where Property: Comparable {
    return { $0.sortedBy(keyPath: keyPath, defaultValue: defaultValue) }
}

public extension Array {
    mutating func sortBy<T>(keyPath: KeyPath<Element, T>) where T: Comparable {
        self.sort(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath]})
    }
    mutating func sortBy<T>(keyPath: KeyPath<Element, T?>, defaultValue: T) where T: Comparable {
        self.sort(by: { $0[keyPath: keyPath] ?? defaultValue < $1[keyPath: keyPath] ?? defaultValue })
    }
}

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

// Some simple functions to clean up functional comparisons

public func isLessThan<T: Comparable>(_ t: T) -> (T) -> Bool {
    return { $0 < t }
}

public func isGreaterThan<T: Comparable>(_ t: T) -> (T) -> Bool {
    return { $0 > t }
}

public func isEqualTo<T: Comparable>(_ t: T) -> (T) -> Bool {
    return { $0 == t }
}

public func isGreaterOrEqualThan<T: Comparable>(_ t: T) -> (T) -> Bool {
    return { $0 >= t }
}

public func isLessOrEqualThan<T: Comparable>(_ t: T) -> (T) -> Bool {
    return { $0 <= t }
}

public func isContainedIn<T: Comparable>(_ ts: [T]) -> (T) -> Bool {
    return { ts.contains($0) }
}

public func isNotContainedIn<T: Comparable>(_ ts: [T]) -> (T) -> Bool {
    return { ts.contains($0) }
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

public func setter<Root, Value>(_ kp: WritableKeyPath<Root, Value>) -> (Root, Value) -> Void {
    return { root, val in
        var copy = root
        copy[keyPath: kp] = val
    }
}

/**
 The following are from the excellent PointFree videos, and are used here and there above to
 implement some of functions.
 */

public func >>> <U, V> (f: @escaping () -> U, g: @escaping (U) -> V) -> () -> V {
    return { g(f()) }
}

public func prop<Root, Value>(_ kp: WritableKeyPath<Root, Value>)
  -> (@escaping (Value) -> Value)
  -> (Root) -> Root {

    return { update in
      { root in
        var copy = root
        copy[keyPath: kp] = update(copy[keyPath: kp])
        return copy
      }
    }
}

public func prop<Root, Value>(
  _ kp: WritableKeyPath<Root, Value>,
  _ f: @escaping (Value) -> Value
  )
  -> (Root) -> Root {

    return prop(kp)(f)
}

public func prop<Root, Value>(
  _ kp: WritableKeyPath<Root, Value>,
  _ value: Value
  )
  -> (Root) -> Root {

    return prop(kp) { _ in value }
}

public typealias Setter<S, T, A, B> = (@escaping (A) -> B) -> (S) -> T

public func over<S, T, A, B>(
  _ setter: Setter<S, T, A, B>,
  _ set: @escaping (A) -> B
  )
  -> (S) -> T {
    return setter(set)
}

public func set<S, T, A, B>(
  _ setter: Setter<S, T, A, B>,
  _ value: B
  )
  -> (S) -> T {
    return over(setter) { _ in value }
}

public func set<Root, Value>(_ kp: WritableKeyPath<Root, Value>, _ value: Value) -> (Root) -> Void {
    return {
        var copy = $0
        copy[keyPath: kp] = value
    }
}

public func get<Root, Value>(_ kp: KeyPath<Root, Value>) -> (Root) -> Value {
  return { root in
    root[keyPath: kp]
  }
}

public typealias MutableSetter<S, A> = (@escaping (inout A) -> Void) -> (inout S) -> Void

public func mver<S, A>(
  _ setter: MutableSetter<S, A>,
  _ set: @escaping (inout A) -> Void
  )
  -> (inout S) -> Void {
    return setter(set)
}

public func mut<S, A>(
  _ setter: MutableSetter<S, A>,
  _ value: A
  )
  -> (inout S) -> Void {
    return mver(setter) { $0 = value }
}

public func mutEach<A>(_ f: @escaping (inout A) -> Void) -> (inout [A]) -> Void {
  return {
    for i in $0.indices {
      f(&$0[i])
    }
  }
}
