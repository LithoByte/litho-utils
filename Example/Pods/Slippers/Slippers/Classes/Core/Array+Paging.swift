//
//  Array+Paging.swift
//  Slippers
//
//  Created by Elliot Schrock on 7/7/20.
//

import Foundation

public extension Array {
    func page(number: Int, per: Int) -> Array<Element> {
        let count = self.count
        if count < number * per {
            return Array<Element>()
        } else if count < (number + 1) * per {
            return Array(self[(number * per)..<count])
        }
        return Array(self[(number * per)..<((number + 1) * per)])
    }
}
