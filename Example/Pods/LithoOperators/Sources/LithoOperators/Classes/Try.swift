//
//  Try.swift
//  LithoOperators
//
//  Created by Elliot Schrock on 6/23/21.
//

import Foundation

public func optTry<T, U>(f: @escaping (T) throws -> U) -> (T) -> U? {
    return { t in
        try? f(t)
    }
}

public func optTry<T, U, V>(f: @escaping (T, U) throws -> V) -> (T, U) -> V? {
    return { t, u in
        try? f(t, u)
    }
}

public func forceTry<T, U>(f: @escaping (T) throws -> U) -> (T) -> U {
    return { t in
        try! f(t)
    }
}

public func forceTry<T, U, V>(f: @escaping (T, U) throws -> V) -> (T, U) -> V {
    return { t, u in
        try! f(t, u)
    }
}

public func tryCatch<T, U>(f: @escaping (T) throws -> U, catcher: @escaping () -> Void) -> (T) throws -> U?  {
    return { t in
        do {
            return try f(t)
        } catch {
            catcher()
            return nil
        }
    }
}

public func tryCatch<T, U, V>(f: @escaping (T, U) throws -> V, catcher: @escaping () -> Void) -> (T, U) -> V? {
    return { t, u in
        do {
            return try f(t, u)
        } catch {
            catcher()
            return nil
        }
    }
}

public func tryCatch<T, U, V>(f: @escaping (T) throws -> U, catcher: @escaping (V) -> Void) -> (T) -> U? where V: Error {
    return { t in
        do {
            return try f(t)
        } catch {
            if let err = error as? V {
                catcher(err)
            }
            return nil
        }
    }
}

public func tryCatch<T, U, V, X>(f: @escaping (T, U) throws -> V, catcher: @escaping (X) -> Void) -> (T, U) -> V? where X: Error {
    return { t, u in
        do {
            return try f(t, u)
        } catch {
            if let err = error as? X {
                catcher(err)
            }
            return nil
        }
    }
}
