//
//  FUICollectionViewViewController.swift
//  fuikit
//
//  Created by Elliot Schrock on 10/21/20.
//

import UIKit

open class FUICollectionViewViewController: UIViewController {
    @IBOutlet public weak var collectionView: UICollectionView!
    
    public var onLoadView: ((FUICollectionViewViewController) -> Void)?
    public var onViewDidLoad: ((FUICollectionViewViewController) -> Void)?
    public var onViewWillAppear: ((FUICollectionViewViewController, Bool) -> Void)?
    public var onViewDidAppear: ((FUICollectionViewViewController, Bool) -> Void)?
    public var onViewWillDisappear: ((FUICollectionViewViewController, Bool) -> Void)?
    public var onViewDidDisappear: ((FUICollectionViewViewController, Bool) -> Void)?
    
    public var onShouldPerformSegue: ((FUICollectionViewViewController, String, Any?) -> Bool )?
    public var onPrepare: ((FUICollectionViewViewController, UIStoryboardSegue, Any?) -> Void)?
    public var onViewWillLayoutSubviews: ((FUICollectionViewViewController) -> Void)?
    public var onViewDidLayoutSubviews: ((FUICollectionViewViewController) -> Void)?
    public var onUpdateViewConstraints: ((FUICollectionViewViewController) -> Void)?
    public var onViewLayoutMarginsDidChange: ((FUICollectionViewViewController) -> Void)?
    public var onViewSafeAreaInsetsDidChange: ((FUICollectionViewViewController) -> Void)?
    
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
