//
//  ArgumentManipulation.swift
//  LithoOperators
//
//  Created by Elliot Schrock on 6/23/21.
//

import Prelude

/**
 This is basically an operator for currying. It puts the value `a` into the first postion of a function `f`
 from `(A, B) -> C` and returns a function that just accepts a value for `B`. In Prelude this would
 be ` a |> curry(f)`.
 */
infix operator *->: AdditionPrecedence
/**
 Substitutes the value on the left into the first argument of the function on the right.
 */
public func *-><A, B, C>(a: A, f: @escaping (A, B) -> C) -> (B) -> C {
    return { b in f(a, b) }
}

infix operator **->: AdditionPrecedence
/**
 Substitutes the tuple on the left into the first two arguments of the function on the right.
 */
public func **-><A, B, C, D>(tuple: (A, B), f: @escaping (A, B, C) -> D) -> (C) -> D {
    return { c in f(tuple.0, tuple.1, c) }
}

infix operator *-->: AdditionPrecedence
/**
 Substitutes the value on the left into the first argument of the function on the right.
 */
public func *--><A, B, C, D>(a: A, f: @escaping (A, B, C) -> D) -> (B, C) -> D {
    return { b, c in f(a, b, c) }
}

infix operator *--->: AdditionPrecedence
/**
 Substitutes the value on the left into the first argument of the function on the right.
 */
public func *---><A, B, C, D, E>(a: A, f: @escaping (A, B, C, D) -> E) -> (B, C, D) -> E {
    return { b, c, d in f(a, b, c, d) }
}

infix operator *---->: AdditionPrecedence
/**
 Substitutes the value on the left into the first argument of the function on the right.
 */
public func *----><A, B, C, D, E, F>(a: A, f: @escaping (A, B, C, D, E) -> F) -> (B, C, D, E) -> F {
    return { b, c, d, e in f(a, b, c, d, e) }
}

infix operator *----->: AdditionPrecedence
/**
 Substitutes the value on the left into the first argument of the function on the right.
 */
public func *-----><A, B, C, D, E, F, G>(a: A, f: @escaping (A, B, C, D, E, F) -> G) -> (B, C, D, E, F) -> G {
    return { b, c, d, e, eff in f(a, b, c, d, e, eff) }
}

//TESTED
/**
 Similar to `*>`, but with the second value. So consider `f: (A, B) -> C`. Then `b >||> f`
 will put `b` into the second argument of `f` and return a function from `A -> C`. I find this more
 ergonmic than using `curry` in this case, since I don't need to swap the arguments around or anything.
 The use case for this is mostly with the free `map` function defined below, so for instance, if you had
 a function `f` from `Int -> String` and wanted to use it to change an array of `Int`s to `String`s,
 you could do so by saying: `f ||> map` which would return a function from `[Int] -> [String]`
 */
infix operator -*>: AdditionPrecedence
/**
 Substitutes the value on the left into the second argument of the function on the right.
 */
public func -*><A, B, C>(b: B, f: @escaping (A, B) -> C) -> (A) -> C {
    return { a in f(a, b) }
}

infix operator -**>: AdditionPrecedence
/**
 Substitutes the value on the left into the last two arguments of the function on the right.
 */
public func -**><A, B, C, D>(tuple: (B, C), f: @escaping (A, B, C) -> D) -> (A) -> D {
    return { a in f(a, tuple.0, tuple.1) }
}

infix operator -***>: AdditionPrecedence
/**
 Substitutes the value on the left into the last three arguments of the function on the right.
 */
public func -***><A, B, C, D, E>(tuple: (B, C, D), f: @escaping (A, B, C, D) -> E) -> (A) -> E {
    return { a in f(a, tuple.0, tuple.1, tuple.2) }
}

infix operator --*>: AdditionPrecedence
/**
 Substitutes the value on the left into the last argument of the function on the right.
 */
public func --*><A, B, C, D>(c: C, f: @escaping (A, B, C) -> D) -> (A, B) -> D {
    return { a, b in f(a, b, c) }
}

infix operator --**>: AdditionPrecedence
/**
 Substitutes the value on the left into the last two arguments of the function on the right.
 */
public func --**><A, B, C, D, E>(tuple: (C, D), f: @escaping (A, B, C, D) -> E) -> (A, B) -> E {
    return { a, b in f(a, b, tuple.0, tuple.1) }
}

infix operator ---*>: AdditionPrecedence
/**
 Substitutes the value on the left into the last argument of the function on the right.
 */
public func ---*><A, B, C, D, E>(d: D, f: @escaping (A, B, C, D) -> E) -> (A, B, C) -> E {
    return { a, b, c in f(a, b, c, d) }
}

infix operator ----*>: AdditionPrecedence
/**
 Substitutes the value on the left into the last argument of the function on the right.
 */
public func ----*><A, B, C, D, E, F>(e: E, f: @escaping (A, B, C, D, E) -> F) -> (A, B, C, D) -> F {
    return { a, b, c, d in f(a, b, c, d, e) }
}

infix operator -----*>: AdditionPrecedence
/**
 Substitutes the value on the left into the last argument of the function on the right.
 */
public func -----*><A, B, C, D, E, F, G>(eff: F, f: @escaping (A, B, C, D, E, F) -> G) -> (A, B, C, D, E) -> G {
    return { a, b, c, d, e in f(a, b, c, d, e, eff) }
}

/**
 These operators \have a subsitition effect on functions, instead of a currying effect. This allows you to take a function, say g: (Int, Int) -> Int, and use another function f: (String) -> Int, and substitute f into g to make g': (String, Int) -> Int. Note that the one parameter case is achieved by the >>> operator.
 */
infix operator >*->: AdditionPrecedence
public func >*-><A, B, C, D>(f: @escaping (A) -> B, g: @escaping (B, C) -> D) -> (A, C) -> D {
    return uncurry(f >>> curry(g))
}
infix operator >*-->: AdditionPrecedence
public func >*--><A, B, C, D, E>(f: @escaping (A) -> B, g: @escaping (B, C, D) -> E) -> (A, C, D) -> E {
    return uncurry(f >>> curry(g))
}
infix operator >-*>: AdditionPrecedence
public func >-*><A, B, C, D>(f: @escaping (A) -> C, g: @escaping (B, C) -> D) -> (B, A) -> D {
    return flip(uncurry(f >>> curry(flip(g))))
}
infix operator >-*->: AdditionPrecedence
public func >-*-><A, B, C, D, E>(f: @escaping (A) -> C, g: @escaping (B, C, D) -> E) -> (B, A, D) -> E {
    return shiftRight(uncurry(f >>> curry(shiftLeft(g))))
}
infix operator >--*>: AdditionPrecedence
public func >--*><A, B, C, D, E>(f: @escaping (A) -> D, g: @escaping (B, C, D) -> E) -> (B, C, A) -> E {
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
infix operator >*>: AdditionPrecedence
public func >*><A, C>(f: @escaping () -> A, g: @escaping (A) -> C) -> () -> C {
    return { g(f()) }
}
public func >*><S, T, U>(f: @escaping (S) -> T, g: @escaping (T) -> U) -> (S) -> U {
    return { g(f($0)) }
}
public func >*-><A, B, C>(f: @escaping () -> A, g: @escaping (A, B) -> C) -> (B) -> C {
    return { b in
        g(f(), b)
    }
}
public func >*--><A, B, C, D>(f: @escaping () -> A, g: @escaping (A, B, C) -> D) -> (B, C) -> D {
    return { b, c in
        g(f(), b, c)
    }
}
public func >-*><A, B, C>(f: @escaping () -> B, g: @escaping (A, B) -> C) -> (A) -> C {
    return { a in
        g(a, f())
    }
}
public func >-*-><A, B, C, D>(f: @escaping () -> B, g: @escaping (A, B, C) -> D) -> (A, C) -> D {
    return { a, c in
        g(a, f(), c)
    }
}
public func >--*><A, B, C, D>(f: @escaping () -> C, g: @escaping (A, B, C) -> D) -> (A, B) -> D {
    return { a, b in
        g(a, b, f())
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
public func ignoreIrrelevantArgs<T, U, V, X>(f: @escaping (T, U) -> X) -> (T, U, V) -> X {
    return { t, u, _ in
        f(t, u)
    }
}
public func ignoreIrrelevantArgs<T, U, V, X>(f: @escaping (U, V) -> X) -> (T, U, V) -> X {
    return { _, u, v in
        f(u, v)
    }
}
public func ignoreIrrelevantArgs<T, U, V, X>(f: @escaping (T, V) -> X) -> (T, U, V) -> X {
    return { t, _, v in
        f(t, v)
    }
}
public func ignoreIrrelevantArgs<T, U, V, X>(f: @escaping (T) -> X) -> (T, U, V) -> X {
    return { t, _, _ in
        f(t)
    }
}
public func ignoreIrrelevantArgs<T, U, V, X>(f: @escaping (V) -> X) -> (T, U, V) -> X {
    return { _, _, v in
        f(v)
    }
}
public func ignoreIrrelevantArgs<T, U, V, X>(f: @escaping (U) -> X) -> (T, U, V) -> X {
    return { _, u, v in
        f(u)
    }
}
public func ignoreIrrelevantArgs<T, U, V, X, Y>(f: @escaping (T, V) -> Y) -> (T, U, V, X) -> Y {
    return { t, _, v, _ in
        f(t, v)
    }
}
public func ignoreIrrelevantArgs<T, U, V, X, Y>(f: @escaping (T, X) -> Y) -> (T, U, V, X) -> Y {
    return { t, _, _, x in
        f(t, x)
    }
}
public func ignoreIrrelevantArgs<T, U, V, X, Y>(f: @escaping (V, X) -> Y) -> (T, U, V, X) -> Y {
    return { _, _, v, x in
        f(v, x)
    }
}
public func ignoreIrrelevantArgs<T, U, V, X, Y>(f: @escaping (U, V) -> Y) -> (T, U, V, X) -> Y {
    return { _, u, v, _ in
        f(u, v)
    }
}
public func ignoreIrrelevantArgs<T, U, V, X, Y>(f: @escaping (U, X) -> Y) -> (T, U, V, X) -> Y {
    return { _, u, _, x in
        f(u, x)
    }
}
public func ignoreIrrelevantArgs<T, U, V, X, Y>(f: @escaping (T, U) -> Y) -> (T, U, V, X) -> Y {
    return { t, u, _, _ in
        f(t, u)
    }
}
public func ignoreIrrelevantArgs<T, U, V, X, Y>(f: @escaping (T, U, V) -> Y) -> (T, U, V, X) -> Y {
    return { t, u, v, _ in
        f(t, u, v)
    }
}
public func ignoreIrrelevantArgs<T, U, V, X, Y>(f: @escaping (T, V, X) -> Y) -> (T, U, V, X) -> Y {
    return { t, _, v, x in
        f(t, v, x)
    }
}
public func ignoreIrrelevantArgs<T, U, V, X, Y>(f: @escaping (U, V, X) -> Y) -> (T, U, V, X) -> Y {
    return { _, u, v, x in
        f(u, v, x)
    }
}
public func ignoreIrrelevantArgs<T, U, V, X, Y>(f: @escaping (T, U, X) -> Y) -> (T, U, V, X) -> Y {
    return { t, u, _, x in
        f(t, u, x)
    }
}
