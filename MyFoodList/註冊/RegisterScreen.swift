//
//  ResigterScreen.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/18.
//

import UIKit

class RegisterScreen: MyViewController {

    private let logoImage = MyPackageImage()
    private let registerField = RegisterFieldUI()
    private let registerButton = MyPackageButton()
    private let backButton = MyPackageButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func verify() {
        var isValid = true
        
        for textFieldType in RegisterFieldType.allCases {
            
            let verifyText = registerField.getFieldText(textFieldType)
            var errorMessage = String()
            
            switch textFieldType {
            case .name:
                errorMessage = "暱稱"
            case .account:
                errorMessage = "帳號"
            case .password, .password_Check:
                errorMessage = "密碼"
            }
            
            if let selectText = verifyText, selectText.isEmpty {
                registerField.setErrorMessage(textFieldType, isShow: true, errorMessage + "不可為空")
                isValid = false
            }
        }
        
        if isValid {
            for textFieldType in RegisterFieldType.allCases {
                registerField.setErrorMessage(textFieldType, isShow: false)
            }
            
            //TODO: - 註冊寫入資料 FireStore
        }
    }
}

//MARK: - UI
extension RegisterScreen {
    private func setupUI() {
        
        let width = UIScreen.main.bounds.width
        
        registerField.setDelegate(self)
        
        logoImage.setImage = .registerLogo
        logoImage.viewPadding(to: width * 0.075)
                
        let spacer = MySpacer()
        
        registerButton.buttonText = "註冊"
        registerButton.textFont = .boldTitle2
        registerButton.buttonCornerRadius = 25
        registerButton.buttonBackground = .oceanBlue
        registerButton.viewPadding(to: width * 0.1, top: width * 0.015, bottom: width * 0.015)
        registerButton.buttonAction = { [weak self] in self?.verify() }
        
        backButton.buttonText = "返回"
        backButton.textFont = .boldTitle2
        backButton.textColor = .oceanBlue
        backButton.buttonBackground = .pureWhite
        backButton.buttonCornerRadius = 25
        backButton.buttonBorderWidth = 4
        backButton.buttonBorderColor = UIColor.oceanBlue.cgColor
        backButton.viewPadding(to: width * 0.1, top: width * 0.02, bottom: width * 0.02)
        backButton.buttonAction = { [weak self] in self?.popViewController() }
        
        let appScreen = MyStack(arrangedSubviews: [logoImage, registerField, spacer, registerButton, backButton])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            logoImage.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.325),
            registerField.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.475),
            spacer.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.01),
            registerButton.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.09),
            backButton.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1)
        ])
    }
}

//MARK: - UITextFieldDelegate
extension RegisterScreen: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        if textField != registerField.getTextField(.name) {
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            let regex = "^[A-Za-z0-9]*$"
            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
            
            let confirmation: Bool = predicate.evaluate(with: updatedText)
            
            return confirmation
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
                
        var registerFieldType: RegisterFieldType!
        switch textField {
        case registerField.getTextField(.name):
            registerFieldType = .name
        case registerField.getTextField(.account):
            registerFieldType = .account
        case registerField.getTextField(.password):
            registerFieldType = .password
        case registerField.getTextField(.password_Check):
            registerFieldType = .password_Check
        default:
            break
        }
        
        registerField.setErrorMessage(registerFieldType, isShow: false)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let currentText = textField.text

        if textField == registerField.getTextField(.password_Check) {
            
            let regex = "^[A-Za-z0-9]*$"
            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
            
            let confirmation: Bool = predicate.evaluate(with: currentText)
            
            registerField.setErrorMessage(.password_Check, isShow: false)
            
            let verifySame: Bool = currentText == registerField.getFieldText(.password)
            
            if confirmation {
                registerField.setErrorMessage(.password, isShow: !verifySame, "兩次密碼不同")
            }
            
            registerField.setErrorMessage(.password_Check, isShow: !verifySame, "兩次密碼不同")
        }
    }
}
