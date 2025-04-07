//
//  SettingScreen.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/7.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import LocalAuthentication

class SettingScreen: MyViewController {
    
    private let titleBar = AppTitleBar()
    private let userInfo = UserInfoUI()
    
    private let settingLabel = MyLabel()
    private let optionTable = UITableView()

    private let logoutButton = MyPackageButton()
    
    private let db = Firestore.firestore()
    
    private let settingsItem = SettingsItem().settingsData
    
    private var memberID = String()
    private var memberName = String()
    private var password = String()
    private var faceID = String()
    private var setFaceID: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        optionTable.delegate = self
        optionTable.dataSource = self
        
        self.setMyBackgroundColor(.lightGrayWhite)
        setupUI()
        
        Task { await getMemberData() }
    }
    
    private func verify_FaceID() {
        
        let context = LAContext()
        var error: NSError?
        
        // 檢查是否支持生物識別（Face ID 或 Touch ID）
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            // 不支援 Face ID，顯示錯誤信息
            if let error = error {
                let message = "生物識別不可用: \(error.localizedDescription)"
                showMessage(message)
            }
            return
        }
        
        let reason = "使用 Face ID 進行身份驗證"
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
            DispatchQueue.main.async {
                if success {
                    // 認證成功，獲取回傳 ID，轉換為 String
                    if let policyDomainState = context.evaluatedPolicyDomainState {
                        self.faceID = policyDomainState.base64EncodedString()
                        
                        Task { await self.updataUserInfo(.face_ID, self.faceID) }
                    }
                } else {
                    // 認證失敗，顯示錯誤信息
                    let message: String
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
                    } else {
                        message = "認證發生錯誤"
                    }
                    
                    self.showMessage(message)
                }
            }
        }
    }

}

//MARK: - UI
extension SettingScreen {
    private func setupUI() {
        
        let width = UIScreen.main.bounds.width
        
        titleBar.setTitle = "設定"
        
        settingLabel.text = "系統"
        settingLabel.font = .boldBody
        settingLabel.textAlignment = .left
        settingLabel.padding(left: width * 0.075)
        
        optionTable.register(SettingOptionCell.self, forCellReuseIdentifier: "SettingOptionCell")
        optionTable.separatorStyle = .none
        optionTable.backgroundColor = .clear
        optionTable.isScrollEnabled = false
        optionTable.translatesAutoresizingMaskIntoConstraints = false
        
        let spacer = MySpacer()
        
        logoutButton.buttonText = "登出"
        logoutButton.textColor = .pureWhite
        logoutButton.buttonBackground = .coralRed
        logoutButton.viewPadding(to: width * 0.05, top: 0, bottom: width * 0.075)
        logoutButton.buttonAction = { [weak self] in
            guard let self = self else { return }
            
            UserDefaults.standard.set(false, forKey: UserDefaultsKey.isLogin.rawValue)
            self.clearToViewController(LoginScreen())
        }
        
        let appScreen = MyStack(arrangedSubviews: [titleBar, userInfo, settingLabel, optionTable, spacer, logoutButton])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            userInfo.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.175),
            settingLabel.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.05),
            optionTable.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.5),
            spacer.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.05),
            logoutButton.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.125),
        ])
    }
}

//MARK: - TableDelegate
extension SettingScreen: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingsItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingOptionCell", for: indexPath) as? SettingOptionCell else {
            return UITableViewCell()
        }
        
        let index = indexPath.row
        let data = settingsItem[index]
        
        cell.setOptionText = data.name
        cell.isShowSwitch = data.isShowSwitch
        
        if data.type == .face_ID {
            cell.setSwitchOn = setFaceID
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let height = view.safeAreaLayoutGuide.layoutFrame.height

        return height * 0.1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let index = indexPath.row
        let data = settingsItem[index]

        switch data.type {
        case .edit_Name, .reset_Password:
            
            let settingAlert = SettingAlert()
            settingAlert.setUserInfoDelegate = self
            settingAlert.settingsType = data.type
            
            overlayAlert(settingAlert)
            
        case .face_ID:
            if !setFaceID {
                self.verify_FaceID()
            } else {
                Task { await self.deleteFaceID() }
            }
        }
    }
}

//MARK: - FireStore
extension SettingScreen {
    private func getMemberData() async {
        
        showLoading()
        
        memberID = UserDefaults.standard.string(forKey: UserDefaultsKey.user_id.rawValue) ?? ""
        
        do {
            let data = db.collection(FireStoreKey.Member.rawValue).document(memberID)
            let dataResponse = try await data.getDocument()
            
            memberName = dataResponse["Name"] as! String
            userInfo.setUserName = memberName
            
            let data_Login = db.collection(FireStoreKey.Login.rawValue).document(memberID)
            let dataResponse_login = try await data_Login.getDocument()
                        
            setFaceID = (dataResponse_login["FaceID"] as! String != "")
            UserDefaults.standard.set(setFaceID, forKey: UserDefaultsKey.isSetFaceID.rawValue)
            
            optionTable.reloadData()
            
        } catch {
            MyPrint("Firestore 註冊失敗: \(error.localizedDescription)")
        }
        
        dismissLoading()
    }
        
    private func updataUserInfo(_ type: SettingsType, _ updataValue: String?) async {
        
        showLoading()
        
        memberID = UserDefaults.standard.string(forKey: UserDefaultsKey.user_id.rawValue) ?? ""

        do {
            if let updataValue = updataValue {
                switch type {
                case .edit_Name:
                    
                    let memberData = db.collection(FireStoreKey.Member.rawValue).document(memberID)
                    try await memberData.setData(["Name": updataValue], merge: true)
                    userInfo.setUserName = updataValue
                    
                case .reset_Password, .face_ID:
                    
                    let loginData = db.collection(FireStoreKey.Login.rawValue).document(memberID)
                    let key = type == .face_ID ? "FaceID" : "Password"
                    try await loginData.setData([key: updataValue], merge: true)
                    
                    if type == .face_ID { optionTable.reloadData() }
                }
            }
            
        } catch {
            MyPrint("Firestore 設定 FaceID 失敗: \(error.localizedDescription)")
        }
        
        dismissLoading()
    }
    
    private func deleteFaceID() async {
        
        showLoading()
        
        do {
            let memberData = db.collection(FireStoreKey.Member.rawValue).document(memberID)
            try await memberData.setData(["FaceID": ""], merge: true)
            
            let loginData = db.collection(FireStoreKey.Login.rawValue).document(memberID)
            try await loginData.setData(["FaceID": ""], merge: true)
            
            faceID = ""
            setFaceID = false
            
            UserDefaults.standard.set(setFaceID, forKey: UserDefaultsKey.isSetFaceID.rawValue)
            
            optionTable.reloadData()
            
        } catch {
            MyPrint("Firestore 刪除 FaceID 失敗: \(error.localizedDescription)")
        }
        
        dismissLoading()
    }

}

//MARK: - SetUserInfoDelegate
extension SettingScreen: SetUserInfoDelegate {
    func setUserInfo(_ type: SettingsType, _ newUserInfo: String?) {
        
        if let newUserInfo = newUserInfo {
            switch type {
            case .edit_Name:
                memberName = newUserInfo
            case .reset_Password:
                password = newUserInfo
            case .face_ID:
                break
            }
            
            Task { await updataUserInfo(type, newUserInfo) }
        }
    }
}
