//
//  SearchViewModel.swift
//  fuikit
//
//  Created by Elliot Schrock on 3/10/20.
//

import UIKit

open class FUISearchBarDelegate: NSObject, UISearchBarDelegate {
    public var onSearchBarShouldBeginEditing: ((UISearchBar) -> Bool)?
    public var onSearchBarTextDidBeginEditing: ((UISearchBar) -> Void)?
    public var onSearchBarShouldEndEditing: ((UISearchBar) -> Bool)?
    public var onSearchBarTextDidEndEditing: ((UISearchBar) -> Void)?
    public var onSearchBarTextDidChange: ((UISearchBar, String) -> Void)?
    public var onSearchBarShouldChangeText: ((UISearchBar, NSRange,String) -> Bool)?
    public var onSearchBarSearchButtonClicked: ((UISearchBar) -> Void)?
    public var onSearchBarBookmarkButtonClicked: ((UISearchBar) -> Void)?
    public var onSearchBarCancelButtonClicked: ((UISearchBar) -> Void)?
    public var onSearchBarResultsListButtonClicked: ((UISearchBar) -> Void)?
    public var onSearchBarSelectedScopeButtonIndexDidChange: ((UISearchBar, Int) -> Void)?
    
    open func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool { return onSearchBarShouldBeginEditing?(searchBar) ?? true }
    open func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) { onSearchBarTextDidBeginEditing?(searchBar) }
    open func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool { return onSearchBarShouldEndEditing?(searchBar) ?? true }
    open func searchBarTextDidEndEditing(_ searchBar: UISearchBar) { onSearchBarTextDidEndEditing?(searchBar) }
    open func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { onSearchBarTextDidChange?(searchBar, searchText) }
    open func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool { return onSearchBarShouldChangeText?(searchBar, range, text) ?? true }
    open func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { onSearchBarSearchButtonClicked?(searchBar) }
    open func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) { onSearchBarBookmarkButtonClicked?(searchBar) }
    open func searchBarCancelButtonClicked(_ searchBar: UISearchBar) { onSearchBarCancelButtonClicked?(searchBar) }
    open func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) { onSearchBarResultsListButtonClicked?(searchBar) }
    open func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) { onSearchBarSelectedScopeButtonIndexDidChange?(searchBar, selectedScope) }
}

