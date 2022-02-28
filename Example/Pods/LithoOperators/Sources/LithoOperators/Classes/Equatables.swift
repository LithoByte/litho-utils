//
//  Equatables.swift
//  LithoOperators
//
//  Created by Elliot on 1/6/22.
//

import Foundation

public func isEqualTo<T: Equatable>(_ t: T) -> (T) -> Bool {
    return { $0 == t }
}

public func isNotEqualTo<T: Equatable>(_ t: T) -> (T) -> Bool {
    return { $0 != t }
}

public func isContainedIn<T: Equatable>(_ ts: [T]) -> (T) -> Bool {
    return { ts.contains($0) }
}

public func isNotContainedIn<T: Equatable>(_ ts: [T]) -> (T) -> Bool {
    return { ts.contains($0) }
}
