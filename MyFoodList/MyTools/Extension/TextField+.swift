//
//  TextField+.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/18.
//

import UIKit

extension UITextField {
    
    // 方法：顯示錯誤信息
    func showError(message: String) {
        // 移除已存在的錯誤標籤
        removeErrorLabel()

        // 創建錯誤標籤
        let errorLabel = UILabel()
        errorLabel.text = message
        errorLabel.textColor = .red
        errorLabel.textAlignment = .right
        errorLabel.font = .caption1
        errorLabel.tag = 999  // 使用 tag 來區分這個錯誤標籤
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 將錯誤標籤添加到父視圖
        guard let superview = self.superview else { return }
        superview.addSubview(errorLabel)
        
        // 添加約束，定位在 TextField 的右下角
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            errorLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 4),
            errorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    // 方法：移除錯誤標籤
    func removeErrorLabel() {
        guard let superview = self.superview else { return }
        
        // 根據 tag 查找並移除之前的錯誤標籤
        superview.subviews.filter({ $0.tag == 999 }).forEach({ $0.removeFromSuperview() })
    }
}
