//
//  View+.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/6.
//

import UIKit

extension UIView {
    func paddingAnchor(equalTo view: UIView, padding: CGFloat = 0,
                       top: CGFloat? = nil, bottom: CGFloat? = nil,
                       left: CGFloat? = nil, right: CGFloat? = nil,
                       equalToTop topView: UIView? = nil,
                       equalToBottom bottomView: UIView? = nil,
                       equalToLeading leadingView: UIView? = nil,
                       equalToTrailing trailingView: UIView? = nil) {

        let topPadding      = top ?? padding
        let bottomPadding   = bottom ?? padding
        let leftPadding     = left ?? padding
        let rightPadding    = right ?? padding

        var constraints: [NSLayoutConstraint] = []
        
        let topAnchorView = topView?.bottomAnchor ?? view.topAnchor
        constraints.append(self.topAnchor.constraint(equalTo: topAnchorView, constant: topPadding))
        
        let bottomAnchorView = bottomView?.topAnchor ?? view.bottomAnchor
        constraints.append(self.bottomAnchor.constraint(equalTo: bottomAnchorView, constant: -bottomPadding))
        
        let leadingAnchorView = leadingView?.trailingAnchor ?? view.leadingAnchor
        constraints.append(self.leadingAnchor.constraint(equalTo: leadingAnchorView, constant: leftPadding))
        
        let trailingAnchorView = trailingView?.leadingAnchor ?? view.trailingAnchor
        constraints.append(self.trailingAnchor.constraint(equalTo: trailingAnchorView, constant: -rightPadding))
        
        NSLayoutConstraint.activate(constraints)
    }
}
