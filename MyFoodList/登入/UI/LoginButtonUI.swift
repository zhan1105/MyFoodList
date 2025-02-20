//
//  LoginButtonUI.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/17.
//

import UIKit

class LoginButtonUI: UIView {
    
    private let loginButton = MyPackageButton()
    
    private let otherLabel = MyLabel()
    private let dashedLine_left_Image = MyPackageImage()
    private let dashedLine_right_Image = MyPackageImage()
    private let otherStack = MyStack()

    private let faceIDButton = MyPackageButton()
    private let registerButton = MyPackageButton()
    private let otherButtonStack = MyStack()
    
    var loginButtonAction: (() -> Void)? {
        didSet {
            loginButton.buttonAction = loginButtonAction
        }
    }
    
    var faceIDButtonAction: (() -> Void)? {
        didSet {
            faceIDButton.buttonAction = faceIDButtonAction
        }
    }
    
    var registerButtonAction: (() -> Void)? {
        didSet {
            registerButton.buttonAction = registerButtonAction
        }
    }

    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: LoginButtonUI) has not been implemented")
    }
    
    private func setupUI(){
        
        let width = UIScreen.main.bounds.width
        
        let topSpacer = MySpacer()
        
        loginButton.buttonText = "登入"
        loginButton.textFont = .boldTitle2
        loginButton.buttonCornerRadius = 25
        loginButton.buttonBackground = .oceanBlue
        loginButton.viewPadding(left: width * 0.1, right: width * 0.1)
                
        otherLabel.text = "或"
        otherLabel.font = .boldTitle2
        
        let images: [MyPackageImage] = [dashedLine_left_Image, dashedLine_right_Image]
        images.forEach {
            $0.setImage = .dashedLine
            $0.setContentMode = .scaleAspectFill
        }
        
        dashedLine_left_Image.viewPadding(left: width * 0.1)
        dashedLine_right_Image.viewPadding(right: width * 0.1)

        otherStack.addArrangedSubviews([dashedLine_left_Image, otherLabel, dashedLine_right_Image])
        otherStack.axis = .horizontal
        otherStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dashedLine_left_Image.widthAnchor.constraint(equalTo: otherStack.widthAnchor, multiplier: 0.45),
            otherLabel.widthAnchor.constraint(equalTo: otherStack.widthAnchor, multiplier: 0.1),
            dashedLine_right_Image.widthAnchor.constraint(equalTo: otherStack.widthAnchor, multiplier: 0.45),
        ])
        
        let buttons: [MyPackageButton] = [faceIDButton, registerButton]
        buttons.forEach {
            $0.textFont = .boldTitle2
            $0.textColor = .oceanBlue
            $0.buttonBackground = .pureWhite
            $0.buttonCornerRadius = 25
            $0.buttonBorderWidth = 4
            $0.buttonBorderColor = UIColor.oceanBlue.cgColor
        }
        
        faceIDButton.buttonText = "Face ID"
        faceIDButton.viewPadding(left: width * 0.1, right: width * 0.025)
        
        registerButton.buttonText = "註冊"
        registerButton.viewPadding(left: width * 0.025, right: width * 0.1)
        
        otherButtonStack.addArrangedSubviews([faceIDButton, registerButton])
        otherButtonStack.axis = .horizontal
        otherButtonStack.distribution = .fillEqually
        otherButtonStack.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomSpacer = MySpacer()
        
        let subScreen = MyStack(arrangedSubviews: [topSpacer, loginButton, otherStack, otherButtonStack, bottomSpacer])
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            topSpacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.135),
            loginButton.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.215),
            otherStack.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.215),
            otherButtonStack.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.215),
            bottomSpacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.22),
        ])
    }
}
