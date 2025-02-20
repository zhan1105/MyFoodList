//
//  NSLocalizedString+.swift
//  transfer
//
//  Created by 紹郁 on 2024/9/16.
//

import Foundation

struct LocalizedStringKey {
    
    enum KeyOptions {
        case shared(Shared)
        
        var rawValue: String {
            switch self {
            case .shared(let key):
                return key.rawValue
            }
        }
    }
}

extension String {
    // 使用 KeyOptions 来获取本地化字符串
    static func localizedString(for key: LocalizedStringKey.KeyOptions, tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "", comment: String = "") -> String {
        return NSLocalizedString(key.rawValue, tableName: tableName, bundle: bundle, value: value, comment: comment)
    }
}
//MARK: - 對應 enum
extension LocalizedStringKey {
    enum Shared: String {
        case none                   = ""
        case inputIsEmpty           = "InputIsEmpty"
        case Send                   = "Send"
        case Agree                  = "Agree"
        case Refuse                 = "Refuse"
        case Confirm                = "Confirm"
        case Try_Again              = "Try_Again"
        case NextStep               = "Next_Step"
        case Clear                  = "Clear"
        case Cancel                 = "Cancel"
        case Got_It                 = "Got_It"
        case Date_Format            = "Date_Format"
        case Back                   = "Back"
        case Complete               = "Complete"
        case See_More               = "See_More"
        case Create                 = "Create"
        case Delete                 = "Delete"
        case Remind                 = "Remind"
        case Service                = "Service"
        case Screenshot_Reminder    = "Screenshot_Reminder"
        case Logout_Message         = "Logout_Message"
    }
}
