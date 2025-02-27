//
//  MyStack.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/29.
//

import UIKit

class MyStack: UIStackView {
    
    private var backgroundImageView: UIImageView?

    var setBackgroundImage: UIImage? {
        get {
            self.backgroundImageView?.image
        }
        set {
            if backgroundImageView == nil {
                let imageView = UIImageView()
                imageView.contentMode = .scaleToFill
                imageView.clipsToBounds = true
                insertSubview(imageView, at: 0)
                
                imageView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: self.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
                ])
                
                backgroundImageView = imageView
            }
            
            backgroundImageView?.image = newValue
        }
    }
    
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
