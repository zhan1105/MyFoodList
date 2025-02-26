//
//  RandomButtonUI.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/25.
//

import UIKit

class RandomButtonUI: UIView {
    
    private let chooseButton = MyPackageButton()
    private let resetButton = MyPackageButton()
    
    var chooseButtonAction: (() -> Void)? {
        didSet {
            chooseButton.buttonAction = chooseButtonAction
        }
    }
    
    var resetButtonAction: (() -> Void)? {
        didSet {
            resetButton.buttonAction = resetButtonAction
        }
    }
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: RandomButtonUI) has not been implemented")
    }
    
    private func setupUI(){
        
        let width = UIScreen.main.bounds.width
        
        chooseButton.buttonText = "決定一個"
        chooseButton.textFont = .boldTitle2
        chooseButton.buttonCornerRadius = 25
        chooseButton.viewPadding(to: width * 0.1, top: 0, bottom: width * 0.065)
        
        resetButton.buttonText = "重置"
        resetButton.textFont = .boldTitle2
        resetButton.textColor = .oceanBlue
        resetButton.buttonBackground = .lightGrayWhite
        resetButton.buttonBorderColor = UIColor.oceanBlue.cgColor
        resetButton.buttonBorderWidth = 4
        resetButton.buttonCornerRadius = 25
        resetButton.viewPadding(to: width * 0.1, top: 0, bottom: width * 0.065)
        
        let subScreen = MyStack(arrangedSubviews: [chooseButton, resetButton])
        subScreen.distribution = .fillEqually
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
