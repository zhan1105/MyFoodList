//
//  SettingItem.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/7.
//

import Foundation

typealias Settings = (type: SettingsType, name: String, isShowSwitch: Bool)

struct SettingsItem {
    
    let settingsData: [Settings] = [(.edit_Name,        "更改暱稱",     false),
                                    (.reset_Password,   "重設密碼",     false),
                                    (.face_ID,          "Face ID",    true)]
}
