//
//  MyDatePickerDelegate.swift
//  transfer
//
//  Created by 紹郁 on 2024/10/9.
//

import Foundation

protocol MyDatePickerDelegate: AnyObject {
    func datePickerDidSelect(date: Date)
}
