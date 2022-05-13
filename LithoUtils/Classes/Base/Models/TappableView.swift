//
//  TappableView.swift
//  LithoUtils
//
//  Created by Calvin Collins on 5/13/22.
//

import Foundation
import LithoOperators

public class TappableView: UIView {
    public var onTap: ((TappableView) -> Void)?
    
    public init(frame: CGRect, onTap: @escaping (TappableView) -> Void) {
        super.init(frame: frame)
        setupGestureRecognizers()
        self.onTap = onTap
    }
    
    public init?(coder: NSCoder, onTap: @escaping (TappableView) -> Void) {
        super.init(coder: coder)
        self.onTap = onTap
        setupGestureRecognizers()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupGestureRecognizers()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGestureRecognizers()
    }
    
    private func setupGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(tap)
    }
    
    @objc func viewTapped() {
        onTap?(self)
    }
}

public class TappableModelView<T>: TappableView {
    public var model: T?
    public init(frame: CGRect, model: T, onTap: @escaping (T, TappableView) -> Void) {
        self.model = model
        super.init(frame: frame, onTap: model *-> onTap)
    }
    
    public init?(coder: NSCoder, model: T, onTap: @escaping (T, TappableView) -> Void) {
        self.model = model
        super.init(coder: coder, onTap: model *-> onTap)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
