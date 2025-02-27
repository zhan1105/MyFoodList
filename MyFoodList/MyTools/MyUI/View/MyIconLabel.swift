//
//  MyIConLabel.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/26.
//

import UIKit

class MyIconLabel: UIView {
    
    private let newLabel = MyLabel()
    private let iconImage = MyPackageImage()

    var setLabel: String? = nil {
        didSet {
            newLabel.text = setLabel
        }
    }
    
    var setIcon: UIImage? = nil {
        didSet {
            iconImage.setImage = setIcon
        }
    }
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: MyIconLabel) has not been implemented")
    }
    
    private func setupUI(){
        
        newLabel.font = .boldBody
        newLabel.textColor = .paleGray
        newLabel.textAlignment = .left
        
        iconImage.viewPadding(to: 5)
        
        let subScreen = MyStack(arrangedSubviews: [iconImage, newLabel])
        subScreen.axis = .horizontal
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            iconImage.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.1),
            newLabel.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.9)
        ])
    }
}
