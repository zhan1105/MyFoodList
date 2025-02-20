//
//  LoginScreen.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/17.
//

import UIKit

class LoginScreen: MyViewController {
    
    private let loginField = LoginFieldUI()
    private let loginButton = LoginButtonUI()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func verify(){
        var isValid = true
        
        for textFieldType in LoginFieldType.allCases {
            
            let verifyText = loginField.getFieldText(textFieldType)
            
            switch textFieldType {
            case .account:
                if let selectText = verifyText, selectText.isEmpty {
                    loginField.showErrorMessage(textFieldType, isShow: true)
                    isValid = false
                }
            case .password:
                if let selectText = verifyText, selectText.isEmpty {
                    loginField.showErrorMessage(textFieldType, isShow: true)
                    isValid = false
                }
            }
        }
        
        if isValid {
            for textFieldType in LoginFieldType.allCases {
                loginField.showErrorMessage(textFieldType, isShow: false)
            }
            
            //TODO: - 登入驗證FireStore
        }
    }
}

//MARK: - UI
extension LoginScreen {
    private func setupUI() {
        
        loginField.setDelegate(self)
        
        loginButton.loginButtonAction = { [weak self] in self?.verify() }
        
        loginButton.faceIDButtonAction = { [weak self] in
            guard let self = self else { return }
        
        }
        loginButton.registerButtonAction = { [weak self] in self?.pushViewController(RegisterScreen()) }
        
        let appScreen = MyStack(arrangedSubviews: [loginField, loginButton])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            loginField.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.65),
            loginButton.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.35),
        ])
    }
}

//MARK: - UITextFieldDelegate
extension LoginScreen: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        let regex = "^[A-Za-z0-9]*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        let confirmation: Bool = predicate.evaluate(with: updatedText)
        
        return confirmation
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
                
        var loginFieldType: LoginFieldType!
        switch textField {
        case loginField.getTextField(.account):
            loginFieldType = .account
        case loginField.getTextField(.password):
            loginFieldType = .password
        default:
            break
        }
        
        loginField.showErrorMessage(loginFieldType, isShow: false)
    }
}

