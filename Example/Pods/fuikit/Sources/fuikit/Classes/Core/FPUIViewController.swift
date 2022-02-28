//
//  FPUIViewController.swift
//  fuikit
//
//  Created by Elliot Schrock on 10/31/19.
//

import UIKit

open class FPUIViewController: UIViewController {
    public var onLoadView: ((FPUIViewController) -> Void)?
    public var onViewDidLoad: ((FPUIViewController) -> Void)?
    public var onViewWillAppear: ((FPUIViewController, Bool) -> Void)?
    public var onViewDidAppear: ((FPUIViewController, Bool) -> Void)?
    public var onViewWillDisappear: ((FPUIViewController, Bool) -> Void)?
    public var onViewDidDisappear: ((FPUIViewController, Bool) -> Void)?
    
    public var onShouldPerformSegue: ((FPUIViewController, String, Any?) -> Bool)?
    public var onPrepare: ((FPUIViewController, UIStoryboardSegue, Any?) -> Void)?
    public var onViewWillLayoutSubviews: ((FPUIViewController) -> Void)?
    public var onViewDidLayoutSubviews: ((FPUIViewController) -> Void)?
    public var onUpdateViewConstraints: ((FPUIViewController) -> Void)?
    public var onViewLayoutMarginsDidChange: ((FPUIViewController) -> Void)?
    public var onViewSafeAreaInsetsDidChange: ((FPUIViewController) -> Void)?
    
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
