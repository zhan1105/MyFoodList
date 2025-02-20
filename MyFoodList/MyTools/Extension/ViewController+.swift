//
//  UIView+.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/15.
//

import UIKit

extension UIViewController {
    
    // MARK: - 切換畫面
    func pushViewController(_ viewController: UIViewController, animated: Bool = true) {
        viewController.modalPresentationStyle = .fullScreen
        
        if animated {
            // 自訂翻頁動畫
            let transition = CATransition()
            transition.duration = 0.5 // 動畫持續時間
            transition.type = .push // 動畫類型
            transition.subtype = .fromRight // 動畫方向，從右邊翻頁
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut) // 動畫的時間曲線
            view.window?.layer.add(transition, forKey: kCATransition)
        }
        
        present(viewController, animated: false)
    }
    
    // MARK: - 返回前一頁
    func popViewController(animated: Bool = true) {
        
        if animated {
            // 自訂翻頁動畫
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = .push
            transition.subtype = .fromLeft
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            view.window?.layer.add(transition, forKey: kCATransition)
        }
        
        dismiss(animated: false, completion: nil)
    }
    
    // MARK: - 清空跳轉
    func clearToViewController(_ mainViewController: UIViewController, _ type: CATransitionSubtype = .fromLeft) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        // 設定 transition
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .push
        transition.subtype = type
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        // 添加動畫到 window 的 layer
        window.layer.add(transition, forKey: kCATransition)
        
        // 設定新的 rootViewController
        window.rootViewController = mainViewController
    }
    
    // MARK: - 蓋在原本的 ViewController 上，不會關閉原本的 ViewController
    func overlayAlert(_ viewController: UIViewController, animated: Bool = true) {
        // 設定 viewController 的 frame
        viewController.view.frame = view.bounds
        
        // 添加子控制器
        addChild(viewController)
        view.addSubview(viewController.view)
        
        // 通知子控制器已經被添加
        viewController.didMove(toParent: self)
        
        if animated {
            // 動畫呈現
            viewController.view.alpha = 0
            UIView.animate(withDuration: 0.5, animations: {
                viewController.view.alpha = 1
            })
        }
    }
    
    // MARK: - 移除覆蓋的 ViewController
    func dismissOverlay(animated: Bool = true) {
        guard parent != nil else { return }  // 確保它是子控制器
        
        if animated {
            // 動畫隱藏
            UIView.animate(withDuration: 0.5, animations: {
                self.view.alpha = 0
            }, completion: { _ in
                // 移除子控制器
                self.willMove(toParent: nil)
                self.view.removeFromSuperview()
                self.removeFromParent()
            })
        } else {
            // 直接移除子控制器
            willMove(toParent: nil)
            view.removeFromSuperview()
            removeFromParent()
        }
    }
}


