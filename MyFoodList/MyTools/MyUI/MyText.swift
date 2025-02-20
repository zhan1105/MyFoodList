//
//  MyText.swift
//  transfer
//
//  Created by 紹郁 on 2024/9/23.
//

import UIKit

class MyTextView: UITextView {
    
    init(text: String = "TextView") {
        super.init(frame: .zero, textContainer: nil)
        setupUI(text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(text: String) {
        self.text = text
        self.textColor = .charcoalBlack
        self.textAlignment = .center
        self.backgroundColor = .clear
        self.isScrollEnabled = false
        self.isEditable = false
        self.isSelectable = false
        self.allowsEditingTextAttributes = false
        self.translatesAutoresizingMaskIntoConstraints = false
//        self.textContainerInset = .zero
        self.padding()
    }
    
    private var textPadding: UIEdgeInsets = .zero
    
    func padding(to padding: CGFloat = 5,
                 top: CGFloat? = nil, bottom: CGFloat? = nil,
                 left: CGFloat? = nil, right: CGFloat? = nil) {
        
        let topPadding      = top ?? padding
        let bottomPadding   = bottom ?? padding
        let leftPadding     = left ?? padding
        let rightPadding    = right ?? padding
        
        textPadding = UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding)
        
        self.textContainerInset = textPadding
    }
}
