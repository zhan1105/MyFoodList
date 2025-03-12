//
//  SetUserInfoDelegate.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/11.
//

import Foundation

protocol SetUserInfoDelegate: AnyObject {
    func setUserInfo(_ type: SettingsType, _ newUserInfo: String?)
}
