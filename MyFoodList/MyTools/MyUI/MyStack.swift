//
//  MyStack.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/29.
//

import UIKit

class MyStack: UIStackView {

    init(arrangedSubviews: [UIView] = []) {
        super.init(frame: .zero)
        self.axis = .vertical
        self.distribution = .fill
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addArrangedSubviews(arrangedSubviews)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            self.addArrangedSubview(view)
        }
    }
}
