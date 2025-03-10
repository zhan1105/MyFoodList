//
//  SettingScreen.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/7.
//

import UIKit

class SettingScreen: MyViewController {
    
    private let titleBar = AppTitleBar()
    private let userInfo = UserInfoUI()
    
    private let settingLabel = MyLabel()
    private let optionTable = UITableView()

    private let logoutButton = MyPackageButton()
    
    private let settingsItem = SettingsItem().settingsData
    
    private var setFaceID: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        optionTable.delegate = self
        optionTable.dataSource = self
        
        self.setMyBackgroundColor(.lightGrayWhite)
        setupUI()
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
        case .edit_Name:
            MyPrint(data.name)
        case .reset_Password:
            MyPrint(data.name)
        case .face_ID:
            MyPrint(data.name)
            setFaceID.toggle()
        }
    
        tableView.reloadData()
    }
}
