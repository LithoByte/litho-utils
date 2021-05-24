//
//  FUIViewController.swift
//  fuikit
//
//  Created by Elliot Schrock on 10/31/19.
//

import UIKit

open class FUIViewController: UIViewController {
    public var onLoadView: ((FUIViewController) -> Void)?
    public var onViewDidLoad: ((FUIViewController) -> Void)?
    public var onViewWillAppear: ((FUIViewController, Bool) -> Void)?
    public var onViewDidAppear: ((FUIViewController, Bool) -> Void)?
    public var onViewWillDisappear: ((FUIViewController, Bool) -> Void)?
    public var onViewDidDisappear: ((FUIViewController, Bool) -> Void)?
    
    public var onShouldPerformSegue: ((FUIViewController, String, Any?) -> Bool)?
    public var onPrepare: ((FUIViewController, UIStoryboardSegue, Any?) -> Void)?
    public var onViewWillLayoutSubviews: ((FUIViewController) -> Void)?
    public var onViewDidLayoutSubviews: ((FUIViewController) -> Void)?
    public var onUpdateViewConstraints: ((FUIViewController) -> Void)?
    public var onViewLayoutMarginsDidChange: ((FUIViewController) -> Void)?
    public var onViewSafeAreaInsetsDidChange: ((FUIViewController) -> Void)?
    
    open override func loadView() {
        onLoadView?(self)
        super.loadView()
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        onViewDidLoad?(self)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onViewWillAppear?(self, animated)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        onViewDidAppear?(self, animated)
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onViewWillDisappear?(self, animated)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        onViewDidDisappear?(self, animated)
    }
    
    open override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return onShouldPerformSegue?(self, identifier, sender) ?? true
    }
    
    open override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        onPrepare?(self, segue, sender)
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        onViewWillLayoutSubviews?(self)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        onViewDidLayoutSubviews?(self)
    }
    
    open override func updateViewConstraints() {
        super.updateViewConstraints()
        onUpdateViewConstraints?(self)
    }
    
    @available(iOS 11.0, *)
    open override func viewLayoutMarginsDidChange() {
        super.viewLayoutMarginsDidChange()
        onViewLayoutMarginsDidChange?(self)
    }
    
    @available(iOS 11.0, *)
    open override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        onViewSafeAreaInsetsDidChange?(self)
    }
}
