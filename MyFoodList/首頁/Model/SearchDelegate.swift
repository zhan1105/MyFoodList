//
//  SearchDelegate.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/5.
//

import Foundation

protocol SearchDelegate: AnyObject {
    func showSearchAlert()
    
    func search(text: String)
}
