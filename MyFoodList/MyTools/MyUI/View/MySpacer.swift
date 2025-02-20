//
//  MySpacer.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/30.
//

import UIKit

class MySpacer: UIView {
    
    init(_ backgroundColor: UIColor = .clear){
        super.init(frame: .zero)
        setupUI(backgroundColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(_ backgroundColor: UIColor){
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
