//
//  Refreshable.swift
//  LUX
//
//  Created by Elliot Schrock on 4/9/20.
//

import Foundation

public protocol Refreshable {
    func refresh()
}

open class Refresher: Refreshable {
    public var onRefresh: (() -> Void)?
    
    public init(_ onRefresh: (() -> Void)?) {
        self.onRefresh = onRefresh
    }
    
    open func refresh() {
        onRefresh?()
    }
}

open class MetaRefresher: Refreshable {
    public var refreshers: [Refreshable]
    
    public init(_ refreshers: Refreshable...) {
        self.refreshers = refreshers
    }
    
    public init(_ refreshers: [Refreshable]) {
        self.refreshers = refreshers
    }
    
    open func refresh() {
        refreshers.forEach { $0.refresh() }
    }
}
