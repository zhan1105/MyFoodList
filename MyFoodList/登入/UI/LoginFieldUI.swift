//
//  LoginFieldUI.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/17.
//

import UIKit

class LoginFieldUI: UIView {

    private let logoImage = MyPackageImage()
    
    private let accountField = AppField()
    private let passwordField = AppPassword()
    
    func setDelegate(_ delegate: UITextFieldDelegate){
        accountField.setDelegate(delegate)
        passwordField.setDelegate(delegate)
    }
    
    func getTextField(_ type: LoginFieldType) -> UITextField {
        switch type {
        case .account:
            accountField.newTextField
        case .password:
            passwordField.newTextField
        }
    }
    
    func getFieldText(_ type: LoginFieldType) -> String? {
        switch type {
        case .account:
            accountField.fieldText
        case .password:
            passwordField.fieldText
        }
    }
    
    func setFieldText(_ type: LoginFieldType, _ text: String) {
        switch type {
        case .account:
            accountField.fieldText = text
        case .password:
            passwordField.fieldText = text
        }
    }
    
    func showErrorMessage(_ type: LoginFieldType, isShow: Bool) {
        switch type {
        case .account:
            accountField.shouldShowError = isShow
            accountField.errorText = "帳號不可為空"
        case .password:
            passwordField.shouldShowError = isShow
            passwordField.errorText = "密碼不可為空"
        }
    }
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: LoginFieldUI) has not been implemented")
    }
    
    private func setupUI(){
        
        let width = UIScreen.main.bounds.width
        
        logoImage.setImage = .loginLogo
        logoImage.viewPadding(to: width * 0.125, top: width * 0.125, bottom: width * 0.175)
        
        accountField.setPlaceholder = "請輸入帳號"
        accountField.setBorderWidth = 3
        accountField.setCornerRadius = 20
        accountField.fieldFont = .boldHeadline
        accountField.setKeyboardType = .asciiCapable
        accountField.setFieldBorderColor = UIColor.skyBlue.cgColor
        
        passwordField.setPlaceholder = "請輸入密碼"
        passwordField.setBorderWidth = 3
        passwordField.setCornerRadius = 20
        passwordField.showFieldIcon = false
        passwordField.fieldFont = .boldHeadline
        passwordField.setKeyboardType = .asciiCapable
        passwordField.setFieldBorderColor = UIColor.skyBlue.cgColor
        
        let subScreen = MyStack(arrangedSubviews: [logoImage, accountField, passwordField])
        subScreen.alignment = .center
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            logoImage.widthAnchor.constraint(equalTo: subScreen.widthAnchor),
            logoImage.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.65),
            
            accountField.widthAnchor.constraint(equalToConstant: width * 0.8),
            accountField.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.175),
            
            passwordField.widthAnchor.constraint(equalToConstant: width * 0.8),
            passwordField.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.175),
        ])
    }
}
