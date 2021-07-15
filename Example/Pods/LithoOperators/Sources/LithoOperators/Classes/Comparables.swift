//
//  Comparables.swift
//  LithoOperators
//
//  Created by Elliot Schrock on 6/23/21.
//

import Foundation

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
