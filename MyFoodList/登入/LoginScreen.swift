//
//  LoginScreen.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/2/17.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import LocalAuthentication

class LoginScreen: MyViewController {
    
    private let loginField = LoginFieldUI()
    private let loginButton = LoginButtonUI()

    private let db = Firestore.firestore()
    
    private var account = String()
    private var password = String()
    private var faceID = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        let isSetFaceID = UserDefaults.standard.bool(forKey: UserDefaultsKey.isSetFaceID.rawValue)
       
        if isSetFaceID {
            verify_FaceID()
        }
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
            
            account = loginField.getFieldText(.account) ?? ""
            password = loginField.getFieldText(.password) ?? ""
            
            Task { await LoginFireStore() }
        }
    }
    
    
    private func verify_FaceID() {
        
        let context = LAContext()
        var error: NSError?
        var message = String()
        
        // 檢查是否支持生物識別（Face ID 或 Touch ID）
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "使用 Face ID 進行身份驗證"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async { [self] in
                    if success {
                        // 認證成功，獲取回傳ID，轉換為 String
                        if let policyDomainState = context.evaluatedPolicyDomainState {
                            faceID = policyDomainState.base64EncodedString()
                                                
                            Task { await LoginFireStore_FaceID() }
                        }
                    } else {
                        // 認證失敗，顯示錯誤信息
                        if let error = authenticationError as? LAError {
                            switch error.code {
                            case .appCancel:
                                message = "應用程式取消認證"
                            case .userCancel:
                                message = "用戶取消認證"
                            case .authenticationFailed:
                                message = "認證失敗"
                            case .biometryNotEnrolled:
                                message = "未設定 Face ID 或 Touch ID"
                            case .biometryLockout:
                                message = "生物識別被鎖定，需要用戶解鎖"
                            default:
                                message = "未知的錯誤"
                            }
                        }
                        showMessage(message)
                    }
                }
            }
        } else {
            // 不支持生物識別，顯示相應的錯誤信息
            if let error = error {
                message = "生物識別不可用: \(error.localizedDescription)"
            }
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
            
            self.verify_FaceID()
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

//MARK: - FireStore
extension LoginScreen {
    private func LoginFireStore() async {
        
        showLoading()
        
        do {
            let data = try await db.collection("Login")
                .whereField("Account", isEqualTo: account) // 搜尋 Account
                .getDocuments()
            
            guard let document = data.documents.first else {
                self.showMessage("帳號不存在")
                
                dismissLoading()
                return
            }
            
            let userData = document.data()
            let userPassword = userData["Password"] as? String ?? ""
            
            if userPassword == password {
                
                let documentID = document.documentID
                UserDefaults.standard.set(documentID, forKey: UserDefaultsKey.user_id.rawValue)
                UserDefaults.standard.set(true, forKey: UserDefaultsKey.isLogin.rawValue)
                
                self.pushViewController(MyTabBarScreen())
            } else {
                self.showMessage("密碼錯誤")
            }
            
        } catch {
            self.showMessage("登入失敗：\(error.localizedDescription)")
            self.MyPrint("登入失敗：\(error.localizedDescription)")
        }
        
        dismissLoading()
    }
    
    private func LoginFireStore_FaceID() async {
        
        showLoading()
        
        do {
            let data = try await db.collection("Login")
                .whereField("FaceID", isEqualTo: faceID) // 搜尋 Account
                .getDocuments()
            
            guard let document = data.documents.first else {
                self.showMessage("FaceID不存在")
                
                dismissLoading()
                return
            }
            
            let documentID = document.documentID
            UserDefaults.standard.set(documentID, forKey: UserDefaultsKey.user_id.rawValue)
            UserDefaults.standard.set(true, forKey: UserDefaultsKey.isLogin.rawValue)

            self.pushViewController(MyTabBarScreen())
            
        } catch {
            self.showMessage("登入失敗：\(error.localizedDescription)")
            self.MyPrint("登入失敗：\(error.localizedDescription)")
        }
        
        dismissLoading()
    }

    
}
