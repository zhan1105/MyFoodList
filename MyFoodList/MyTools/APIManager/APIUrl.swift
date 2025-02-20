//
//  APIUrl.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/2.
//

import Foundation

enum Environment {
    case formal
    case test

    var baseUrl: String {
        switch self {
        case .formal:
            return "https://app.mgtt.com.tw/api/"
        case .test:
            return "https://test.mgtt.com.tw/api/"
        }
    }
}

let App: Environment = .test

enum APIUrl {
    case getPhoneCode               // 111.取得手機驗證碼
    case checkPhoneCode             // 112.驗證手機驗證碼
    case getCatAPI
    
    var rawValue: String {
        switch self {
        case .getPhoneCode:
            return App.baseUrl + "phone_code"
            
        case .checkPhoneCode:
            return App.baseUrl + "checkPhoneCode"
            
        case .getCatAPI:
            return "https://api.thecatapi.com/v1/images/search"
        }
    }
}

