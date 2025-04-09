//
//  TextViewDelegate.swift
//  vim-motions-poc
//
//  Created by Kacper Debowski on 08/04/2025.
//
import SwiftUI
import AppKit

struct TextView: NSViewRepresentable {
    @Binding var text: String
    @Binding var mode: VimMode

    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: TextView

        init(_ parent: TextView) {
            self.parent = parent
        }
        
        func textDidChange(_ notification: Notification) {
            if let textView = notification.object as? VimCapableTextView {
                DispatchQueue.main.async {
                    self.parent.text = textView.string
                    self.parent.mode = textView.mode
                }
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeNSView(context: Context) -> NSScrollView {
        let scrollView = NSScrollView()
        let textView = VimCapableTextView()
        setupDefaultKeybindings(&(textView.keybinds))
        let _ = textView.layoutManager

        textView.delegate = context.coordinator
        textView.isEditable = true
        textView.isRichText = true
        textView.isSelectable = true
        textView.usesFindPanel = true
        textView.autoresizingMask = [.width, .height]

        scrollView.documentView = textView
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true
        scrollView.autohidesScrollers = true
        scrollView.borderType = .bezelBorder
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        // Set constraints to ensure the text view uses the full size of the scroll view
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: scrollView.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: scrollView.contentView.trailingAnchor),
            textView.topAnchor.constraint(equalTo: scrollView.contentView.topAnchor),
            textView.bottomAnchor.constraint(equalTo: scrollView.contentView.bottomAnchor)
        ])

        return scrollView
    }

    func updateNSView(_ nsView: NSScrollView, context: Context) {
        if let textView = nsView.documentView as? VimCapableTextView {
            if textView.string != text {
                textView.string = text
            }
        }
    }
    
}
