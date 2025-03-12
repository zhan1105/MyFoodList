//
//  SetNameAlert.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/11.
//

import UIKit

class SettingAlert: MyViewController {

    weak var setUserInfoDelegate: SetUserInfoDelegate?
    var settingsType: SettingsType?
    
    private let titleLabel = MyLabel()
    private let settingField = AppField()
    private let confirmButton = MyPackageButton()
    private let cancelButton = MyPackageButton()
    
    var nameFieldText: String? {
        get {
            settingField.fieldText
        }
        set {
            settingField.fieldText = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingField.setDelegate(self)
        
        self.setMyBackgroundColor(.charcoalBlack.withAlphaComponent(0.6))
        setupUI()
    }
    
    private func isVerify() {
        
        let verifyText = nameFieldText
        
        if let selectText = verifyText, selectText.isEmpty {
            settingField.errorText = "不可為空"
            settingField.shouldShowError = true
            return
        } else {
            if let settingsType = settingsType {
                self.setUserInfoDelegate?.setUserInfo(settingsType, verifyText)
                self.dismissOverlay()
            }
        }
    }
}

//MARK: - UI
extension SettingAlert {
    private func setupUI() {
        
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        titleLabel.text = settingsType == .edit_Name ? "設定新暱稱" : "設定新密碼"
        titleLabel.font = .boldTitle3
        
        settingField.setPlaceholder = ""
        settingField.setBorderWidth = 3
        settingField.setCornerRadius = 20
        settingField.fieldFont = .boldHeadline
        settingField.setKeyboardType = settingsType == .edit_Name ? .default : .asciiCapable
        settingField.setFieldBorderColor = UIColor.skyBlue.cgColor
        
        confirmButton.buttonText = "確定"
        confirmButton.buttonCornerRadius = 25
        confirmButton.viewPadding(to: width * 0.05, bottom: width * 0.025)
        confirmButton.buttonAction = { [weak self] in self?.isVerify() }
        
        cancelButton.buttonText = "取消"
        cancelButton.textFont = .boldTitle2
        cancelButton.textColor = .oceanBlue
        cancelButton.buttonBackground = .pureWhite
        cancelButton.buttonCornerRadius = 25
        cancelButton.buttonBorderWidth = 4
        cancelButton.buttonBorderColor = UIColor.oceanBlue.cgColor
        cancelButton.viewPadding(to: width * 0.05, top: width * 0.025)
        cancelButton.buttonAction = { [weak self] in self?.dismissOverlay() }
        
        let appScreen = MyStack(arrangedSubviews: [titleLabel, settingField, confirmButton, cancelButton])
        appScreen.distribution = .fillEqually
        appScreen.alignment = .center
        appScreen.backgroundColor = .pureWhite
        appScreen.layer.cornerRadius = 15
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            appScreen.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            appScreen.widthAnchor.constraint(equalToConstant: width * 0.95),
            appScreen.heightAnchor.constraint(equalToConstant: height * 0.45),
            
            titleLabel.widthAnchor.constraint(equalTo: appScreen.widthAnchor),
            settingField.widthAnchor.constraint(equalToConstant: width * 0.85),
            confirmButton.widthAnchor.constraint(equalTo: appScreen.widthAnchor),
            cancelButton.widthAnchor.constraint(equalTo: appScreen.widthAnchor),
        ])
    }
}

//MARK: - UITextFieldDelegate
extension SettingAlert: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        if settingsType == .reset_Password {
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
        settingField.isSelect = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        settingField.isSelect = false
    }
}
