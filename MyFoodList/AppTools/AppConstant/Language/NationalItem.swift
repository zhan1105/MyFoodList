//
//  NationalityOptions.swift
//  transfer
//
//  Created by 紹郁 on 2024/10/14.
//

import UIKit
import Foundation

typealias nation = (language: SwitchLanguage, name: String, image: UIImage)

struct NationalItem {
    
    let option: [nation] = [(.english,        "English",        .smallFlagUs),
                            (.chinese,        "繁體中文",         .smallFlagZh),
    ]
}
