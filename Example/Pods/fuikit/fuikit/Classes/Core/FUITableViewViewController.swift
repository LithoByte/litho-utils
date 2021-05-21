//
//  FUITableViewViewController.swift
//  fuikit
//
//  Created by Eddy Varela on 6/24/20.
//
import UIKit

open class FUITableViewViewController: UIViewController {
    @IBOutlet public var tableView: UITableView?
    
    public var onLoadView: ((FUITableViewViewController) -> Void)?
    public var onViewDidLoad: ((FUITableViewViewController) -> Void)?
    public var onViewWillAppear: ((FUITableViewViewController, Bool) -> Void)?
    public var onViewDidAppear: ((FUITableViewViewController, Bool) -> Void)?
    public var onViewWillDisappear: ((FUITableViewViewController, Bool) -> Void)?
    public var onViewDidDisappear: ((FUITableViewViewController, Bool) -> Void)?
    
    public var onShouldPerformSegue: ((FUITableViewViewController, String, Any?) -> Bool )?
    public var onPrepare: ((FUITableViewViewController, UIStoryboardSegue, Any?) -> Void)?
    public var onViewWillLayoutSubviews: ((FUITableViewViewController) -> Void)?
    public var onViewDidLayoutSubviews: ((FUITableViewViewController) -> Void)?
    public var onUpdateViewConstraints: ((FUITableViewViewController) -> Void)?
    public var onViewLayoutMarginsDidChange: ((FUITableViewViewController) -> Void)?
    public var onViewSafeAreaInsetsDidChange: ((FUITableViewViewController) -> Void)?
    
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
