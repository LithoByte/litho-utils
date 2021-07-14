//
//  KeyPaths.swift
//  LithoOperators
//
//  Created by Elliot Schrock on 6/23/21.
//

import Foundation

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
