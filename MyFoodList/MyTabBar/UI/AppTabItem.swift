//
//  TabBarItem.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/24.
//

import UIKit

class AppTabItem: UIView {

    private let menuImage = MyPackageImage()
    private let menuLabel = MyLabel()
    
    var onTapAction: (() -> Void)?
    
    var setIcon: UIImage? = .homeUnselected {
        didSet {
            menuImage.setImage = setIcon
        }
    }
    
    var setText: String? = nil {
        didSet {
            menuLabel.text = setText
        }
    }
    
    var setTextColor: UIColor = .charcoalBlack {
        didSet {
            menuLabel.textColor = setTextColor
        }
    }
    
    var setTabItem: TabBarType = .FoodList {
        didSet {
            var image: UIImage?
            var itemText: String?
            
            switch setTabItem {
            case .FoodList:
                image = .foodListNotSelected
                itemText = "美食清單"
            case .Location:
                image = .locationNotSelected
                itemText = "附記美食"
            case .WhatToEat:
                image = .whatToEatNotSelected
                itemText = "吃啥？"
            case .Setting:
                image = .settingNotSelected
                itemText = "設定"
            default:
                break
            }
            setIcon = image
            setText = itemText
        }
    }
    
    init(_ type: TabBarType){
        super.init(frame: .zero)
        setupUI(type)
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: AppTabItem) has not been implemented")
    }
    
    private func setupUI(_ type: TabBarType){
     
        setTabItem = type
        
        menuLabel.font = .boldFootnote
        menuLabel.padding(to: 5)
                
        menuImage.viewPadding(to: 7.5)
        
        let subScreen = MyStack(arrangedSubviews: [menuImage, menuLabel])
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            menuImage.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.7),
            menuLabel.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.3),
        ])
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    
    @objc private func handleTap() {
        onTapAction?()
    }
}
