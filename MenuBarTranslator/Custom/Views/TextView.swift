//
//  TextView.swift
//  MenuBarTranslator
//
//  Created by Aiur on 23.03.2021.
//

import Foundation
import SwiftUI

struct TextView: NSViewRepresentable {
    
    @Binding var text: String
    let isFirstResponder: Bool
    let textColor: Color?
    
    init(text: Binding<String>, isFirstResponder: Bool = false, textColor: Color?) {
        self._text = text
        self.isFirstResponder = isFirstResponder
        self.textColor = textColor
    }
    
    func makeCoordinator() -> TextView.Coordinator {
        Coordinator(self)
    }
    
    func makeNSView(context: NSViewRepresentableContext<TextView>) -> NSTextView {
        let textView = NSTextView()
        
        textView.font = .systemFont(ofSize: 13)
        if let textColor = self.textColor {
            textView.textColor = NSColor(textColor)
            textView.insertionPointColor = NSColor(textColor)
        }
        textView.delegate = context.coordinator
        
        textView.backgroundColor = .clear
        
        if isFirstResponder {
            DispatchQueue.main.async {
                textView.window?.makeFirstResponder(textView)
            }
        }
        
        return textView
    }
    
    func updateNSView(_ nsView: NSTextView, context: Context) {
        nsView.string = text
    }
    
    typealias NSViewType = NSTextView
    
    class Coordinator: NSObject, NSTextViewDelegate {
        let parent: TextView
        
        init (_ textView: TextView) {
            self.parent = textView
        }
        
        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else {
                return
            }
            self.parent.text = textView.string
        }
        
        
    }
    
//    class Coordinator: NSObject, NSTextViewDelegate {
//
//        @Binding var text: String
//        var onCommit: (_ value: String) -> Void
//        var didBecomeFirstResponder = false
//
//        init(text: Binding<String>, onCommit: @escaping (_ value: String) -> Void) {
//            _text = text
//            self.onCommit = onCommit
//        }
//
//        func textFieldDidChangeSelection(_ textView: NSTextView) {
//            text = textField.text ?? ""
//        }
//
//        func textFieldShouldReturn(_ textView: NSTextView) -> Bool {
//            textField.resignFirstResponder()
//            onCommit(textField.text ?? "")
//            return true
//        }
//    }
    
}
