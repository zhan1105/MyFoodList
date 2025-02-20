//
//  MyToast.swift
//  transfer
//
//  Created by 紹郁 on 2024/11/5.
//

import UIKit

extension UIView {
    func showToast(message: String, duration: TimeInterval = 2.0) {
        // 設定 toast 的外觀
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = .boldTitle3
        toastLabel.text = message
        toastLabel.numberOfLines = 0
        toastLabel.alpha = 0.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        // 設定 toast 的大小和位置
        let maxWidthPercentage: CGFloat = 0.8
        let maxTitleSize = CGSize(width: self.bounds.size.width * maxWidthPercentage, height: self.bounds.size.height)
        let expectedSize = toastLabel.sizeThatFits(maxTitleSize)
        toastLabel.frame = CGRect(x: (self.frame.size.width - expectedSize.width) / 2 - (expectedSize.width / 2 - 10),
                                  y: self.frame.size.height - expectedSize.height - 80,
                                  width: expectedSize.width + 20,
                                  height: expectedSize.height + 10)
        
        // 將 toast 加入視圖
        self.addSubview(toastLabel)
        
        // 顯示和隱藏動畫
        UIView.animate(withDuration: 0.5, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
}

extension UIViewController {
    func showToast(_ message: String, duration: TimeInterval = 2.0) {
        self.view.showToast(message: message, duration: duration)
    }
}
