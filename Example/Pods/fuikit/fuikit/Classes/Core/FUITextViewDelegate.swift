//
//  FUITextViewDelegate.swift
//  fuikit
//
//  Created by Eddy Varela on 7/6/20.
//

import UIKit

@available(iOS 10.0, *)
public class FUITextViewDelegate: NSObject, UITextViewDelegate {
    public var onTextViewShouldBeginEditing: ((UITextView) -> Bool)?
    public var onTextViewShouldEndEditing: ((UITextView) -> Bool)?
    public var onTextViewDidBeginEditing: ((UITextView) -> Void)?
    public var onTextViewDidEndEditing: ((UITextView) -> Void)?
    public var onShouldChangeTextInRange: ((UITextView, NSRange, String) -> Bool)?
    public var onTextViewDidChange: ((UITextView) -> Void)?
    public var onTextViewDidChangeSelection: ((UITextView) -> Void)?
    public var onShouldInteractWithURL: ((UITextView, URL, NSRange, UITextItemInteraction) -> Bool)?
    public var onShouldInteractWithTextAttachment: ((UITextView, NSTextAttachment, NSRange, UITextItemInteraction) -> Bool)?

    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool { onTextViewShouldBeginEditing?(textView) ?? true }
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool { onTextViewShouldEndEditing?(textView) ?? true }
    public func textViewDidBeginEditing(_ textView: UITextView) { onTextViewDidBeginEditing?(textView) }
    public func textViewDidEndEditing(_ textView: UITextView) { onTextViewDidEndEditing?(textView) }
    public func textViewDidChange(_ textView: UITextView) { onTextViewDidChange?(textView) }
    public func textViewDidChangeSelection(_ textView: UITextView) { onTextViewDidChangeSelection?(textView) }
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool { onShouldChangeTextInRange?(textView, range, text) ?? true }
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool { onShouldInteractWithURL?(textView, URL, characterRange, interaction) ?? true }
    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool { onShouldInteractWithTextAttachment?(textView, textAttachment, characterRange, interaction) ?? true }
}
