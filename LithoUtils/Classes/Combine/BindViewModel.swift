//
//  BindViewModel.swift
//  FunNet
//
//  Created by Calvin Collins on 5/17/21.
//

import Foundation
import Combine
import LithoOperators
import Prelude

@available(iOS 13.0, *)
public func bindButtonEnabledToPublisher(_ button: UIButton, publisher: AnyPublisher<Bool, Never>, cancelBag: inout Set<AnyCancellable>){
    publisher.sink{ button.isEnabled = $0 }.store(in: &cancelBag)
}

@available(iOS 13.0, *)
public func bindActivityIndicatorVisibleToPublisher(_ activity: UIActivityIndicatorView, publisher: AnyPublisher<Bool, Never>, cancelBag: inout Set<AnyCancellable>) {
    publisher.sink{ activity.isHidden = !$0 }.store(in: &cancelBag)
}

@available(iOS 13.0, *)
extension Publisher where Output == Bool, Failure == Never {
    public func bind<T>(to keyPath: WritableKeyPath<T, Bool>, on value: T, storingIn cancelBag: inout Set<AnyCancellable>) {
        self.sink(receiveValue: value >|> setter(keyPath)).store(in: &cancelBag)
    }
}
