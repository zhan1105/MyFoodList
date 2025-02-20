//
//  ResigterUI.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/18.
//

import UIKit

class RegisterFieldUI: UIView {
    
    private let nameField = AppField()
    private let accountField = AppField()
    private let passwordField = AppPassword()
    private let passwordCheckField = AppPassword()

    private let subScreen = MyStack()
    
    func setDelegate(_ delegate: UITextFieldDelegate){
        nameField.setDelegate(delegate)
        accountField.setDelegate(delegate)
        passwordField.setDelegate(delegate)
        passwordCheckField.setDelegate(delegate)
    }
    
    func getTextField(_ type: RegisterFieldType) -> UITextField {
        switch type {
        case .name:
            nameField.newTextField
        case .account:
            accountField.newTextField
        case .password:
            passwordField.newTextField
        case .password_Check:
            passwordCheckField.newTextField
        }
    }
    
    func getFieldText(_ type: RegisterFieldType) -> String? {
        switch type {
        case .name:
            nameField.fieldText
        case .account:
            accountField.fieldText
        case .password:
            passwordField.fieldText
        case .password_Check:
            passwordCheckField.fieldText
        }
    }
    
    func setFieldText(_ type: RegisterFieldType, _ text: String) {
        switch type {
        case .name:
            nameField.fieldText = text
        case .account:
            accountField.fieldText = text
        case .password:
            passwordField.fieldText = text
        case .password_Check:
            passwordCheckField.fieldText = text
        }
    }
    
    func setErrorMessage(_ type: RegisterFieldType, isShow: Bool, _ message: String = "") {
        switch type {
        case .name:
            nameField.shouldShowError = isShow
            nameField.errorText = message
            
        case .account:
            accountField.shouldShowError = isShow
            accountField.errorText = message
            
        case .password:
            passwordField.shouldShowError = isShow
            passwordField.errorText = message
            
        case .password_Check:
            passwordCheckField.shouldShowError = isShow
            passwordCheckField.errorText = message
        }
    }
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ResigterUI) has not been implemented")
    }
    
    private func setupUI(){
        
        let width = UIScreen.main.bounds.width
        
        let appFields: [AppField] = [nameField, accountField]
        appFields.forEach {
            $0.setBorderWidth = 3
            $0.setCornerRadius = 20
            $0.fieldFont = .boldHeadline
            $0.setFieldBorderColor = UIColor.skyBlue.cgColor
        }
        
        nameField.setPlaceholder = "設定暱稱"
        accountField.setPlaceholder = "輸入帳號"
        accountField.setKeyboardType = .asciiCapable
        
        let appPasswords: [AppPassword] = [passwordField, passwordCheckField]
        appPasswords.forEach {
            $0.setBorderWidth = 3
            $0.setCornerRadius = 20
            $0.showFieldIcon = false
            $0.fieldFont = .boldHeadline
            $0.setKeyboardType = .asciiCapable
            $0.setFieldBorderColor = UIColor.skyBlue.cgColor
        }
        
        passwordField.setPlaceholder = "輸入密碼"
        passwordCheckField.setPlaceholder = "再次輸入密碼"
        
        subScreen.addArrangedSubviews([nameField, accountField,
                                       passwordField, passwordCheckField])
        subScreen.distribution = .fillEqually
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor, constant: width * 0.1),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -width * 0.1),
        ])
    }
}
