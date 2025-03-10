//
//  UserInfoUI.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/7.
//

import UIKit

class UserInfoUI: UIView {
    
    private let logoImage = MyPackageImage()
    private let userNameLabel = MyLabel()

    var setUserName: String? {
        get {
            userNameLabel.text
        }
        set {
            userNameLabel.text = newValue
        }
    }
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: UserInfoUI) has not been implemented")
    }
    
    private func setupUI(){
        
        let width = UIScreen.main.bounds.width
        
        logoImage.setImage = .userLogo
        logoImage.setContentMode = .scaleAspectFit
        logoImage.viewPadding(to: width * 0.05)
        
        userNameLabel.text = "使用者"
        userNameLabel.font = .boldTitle3
        userNameLabel.textAlignment = .left
        
        let subScreen = MyStack(arrangedSubviews: [logoImage, userNameLabel])
        subScreen.axis = .horizontal
        subScreen.backgroundColor = .pureWhite
        subScreen.layer.cornerRadius = 10
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor, constant: width * 0.05),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -width * 0.05),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor, constant: width * 0.05),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -width * 0.05),
            
            logoImage.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.25),
            userNameLabel.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.75)
        ])
    }

}
