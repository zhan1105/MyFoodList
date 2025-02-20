//
//  MyButton.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/29.
//

import UIKit

class MyButton: UIButton {
    
    var buttonAction: (() -> Void)?
    
    init(text: String = "") {
        super.init(frame: .zero)
        setupUI(text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(text: String) {
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = UIFont.title2
        self.tintColor = .white
        self.layer.cornerRadius = 10
        self.backgroundColor = .oceanBlue
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func buttonTapped() {
        buttonAction?()
    }
}
