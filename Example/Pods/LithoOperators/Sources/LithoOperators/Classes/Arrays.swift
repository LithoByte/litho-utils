//
//  Arrays.swift
//  LithoOperators
//
//  Created by Elliot Schrock on 6/23/21.
//

import Prelude

public prefix func ^<Element>(_ array: [Element]) -> (Int) -> Element? {
    return { i in
        i < array.count ? array[i] : nil
    }
}

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

public func reverse<T>(array: [T]) -> [T] {
    return array.reversed()
}
public func sortedBy<Element, Property>(keyPath: KeyPath<Element, Property>) -> ([Element]) -> [Element] where Property: Comparable {
    return { $0.sortedBy(keyPath: keyPath) }
}
public func sortedByDescending<Element, Property>(keyPath: KeyPath<Element, Property>) -> ([Element]) -> [Element] where Property: Comparable {
    return sortedBy(keyPath: keyPath) >>> reverse
}
public func sortedBy<Element, Property>(keyPath: KeyPath<Element, Property?>, defaultValue: Property)
-> ([Element]) -> [Element] where Property: Comparable {
    return { $0.sortedBy(keyPath: keyPath, defaultValue: defaultValue) }
}
public func sortedByDescending<Element, Property>(keyPath: KeyPath<Element, Property?>, defaultValue: Property) -> ([Element]) -> [Element] where Property: Comparable {
    return sortedBy(keyPath: keyPath, defaultValue: defaultValue) >>> reverse
}

public extension Array {
    mutating func sortBy<T>(keyPath: KeyPath<Element, T>) where T: Comparable {
        self.sort(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath]})
    }
    mutating func sortBy<T>(keyPath: KeyPath<Element, T?>, defaultValue: T) where T: Comparable {
        self.sort(by: { $0[keyPath: keyPath] ?? defaultValue < $1[keyPath: keyPath] ?? defaultValue })
    }
}
/**
 These functions take in a tuple, of all the same type, and return an array of that many elements. Useful for using the above functions that return a tuple, but you want to do some computation on that tuple (forEach, map, etc.) that takes in an array
 */
public func toArray<T>(_ tuple: (T, T)) -> [T] {
    return [tuple.0, tuple.1]
}
public func toArray<T>(_ tuple: (T, T, T)) -> [T] {
    return [tuple.0, tuple.1, tuple.2]
}
public func toArray<T>(_ tuple: (T, T, T, T)) -> [T] {
    return [tuple.0, tuple.1, tuple.2, tuple.3]
}
public func toArray<T>(_ tuple: (T, T, T, T, T)) -> [T] {
    return [tuple.0, tuple.1, tuple.2, tuple.3, tuple.4]
}

public extension Array {
    init(_ tuple: (Element, Element)) {
        self.init(arrayLiteral: tuple.0, tuple.1)
    }
    init(_ tuple: (Element, Element, Element)) {
        self.init(arrayLiteral: tuple.0, tuple.1, tuple.2)
    }
    init(_ tuple: (Element, Element, Element, Element)) {
        self.init(arrayLiteral: tuple.0, tuple.1, tuple.2, tuple.3)
    }
    init(_ tuple: (Element, Element, Element, Element, Element)) {
        self.init(arrayLiteral: tuple.0, tuple.1, tuple.2, tuple.3, tuple.4)
    }
}
