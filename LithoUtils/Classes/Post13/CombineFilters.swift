//
//  CombineFilters.swift
//  LithoUtils
//
//  Created by Calvin Collins on 10/27/21.
//

import Foundation
import Combine
import LithoOperators
import Prelude

@available(iOS 13.0, *)
extension Publisher where Output == Bool {
    public func onlyTrue() -> AnyPublisher<Bool, Failure> {
        return filter(id).eraseToAnyPublisher()
    }
    
    public func onlyFalse() -> AnyPublisher<Bool, Failure> {
        return filter(id >>> (!)).eraseToAnyPublisher()
    }
}

extension Publisher where Output: Comparable {
    public func onlyLessThan(_ val: Output) -> AnyPublisher<Output, Failure> {
        return filter(isLessThan(val)).eraseToAnyPublisher()
    }
    
    public func onlyGreaterThan(_ val: Output) -> AnyPublisher<Output, Failure> {
        return filter(isGreaterThan(val)).eraseToAnyPublisher()
    }
    
    public func onlyEqualTo(_ val: Output) -> AnyPublisher<Output, Failure> {
        return filter(isEqualTo(val)).eraseToAnyPublisher()
    }
    
    public func onlyLessThanOrEqual(_ val: Output) -> AnyPublisher<Output, Failure> {
        return filter(isLessOrEqualThan(val)).eraseToAnyPublisher()
    }
    
    public func onlyGreaterThanOrEqual(_ val: Output) -> AnyPublisher<Output, Failure> {
        return filter(isGreaterOrEqualThan(val)).eraseToAnyPublisher()
    }
}
