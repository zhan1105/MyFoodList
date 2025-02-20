//
//  MyViewController.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/30.
//

import UIKit

class MyViewController: UIViewController {
    
    private var loadingView: MyLoading?
    private var messageView: MyMessage?
    weak var setMessageDelegate: MyMessageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMyBackgroundColor()
        setupKeyboardObservers()        // 設置鍵盤監聽
        setupDismissKeyboardGesture()   // 設置點擊空白區域收起鍵盤
        
//        NotificationCenter.default.addObserver(self, selector: #selector(userDidTakeScreenshot), name: UIApplication.userDidTakeScreenshotNotification, object: nil)  // 截圖監聽

        
    }
    
    //MARK: - 截圖警示
    @objc func userDidTakeScreenshot() {
        
        let remindText: String = "提醒"
        let Screenshot_Reminder: String = "此畫面請自行保留，切勿分享。"
        
        let alert = UIAlertController(title: remindText, message: Screenshot_Reminder, preferredStyle: .alert)
        self.present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    //MARK: - 設定背景
    func setMyBackgroundColor(_ color: UIColor? = nil, backgroundColor: UIColor = .pureWhite, bottomColor: UIColor = .pureWhite){
        
        view.backgroundColor = color ?? backgroundColor
        
        let bottomColorView = UIView()
        bottomColorView.backgroundColor = color ?? bottomColor
        bottomColorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomColorView)
        
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let bottomSafeAreaHeight = scene?.windows.first?.safeAreaInsets.bottom  //抓取下安全區域高度
        
        NSLayoutConstraint.activate([
            // 上部顏色區域
            bottomColorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomColorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomColorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomColorView.heightAnchor.constraint(equalToConstant: bottomSafeAreaHeight!),
        ])
    }
    
    //MARK: - 系統更新／維護
    func showSystemUpdate(_ message: String, isUpdate: Bool) {
        
        let controller = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        
        if isUpdate {
            let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                guard let self = self else { return }
                
                if let url = URL(string: "https://apps.apple.com/tw/app/mgtt/id1672529361") {
                    UIApplication.shared.open(url)
                }
                self.present(controller, animated: true, completion: nil)
            }
            
            controller.addAction(okAction)
        }
        present(controller, animated: true)
    }
    
    //MARK: - 登出訊息視窗
    func logoutMessage() {
        
        let logout_Message: String = .localizedString(for: .shared(.Logout_Message))
        
        let controller = UIAlertController(title: logout_Message, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default){ _ in
            
            
            
            self.clearToViewController(HomeScreen())
        }
        controller.addAction(okAction)
        present(controller, animated: true)
    }
    
    //MARK: - 訊息視窗
    func showMessage(_ text: String = "") {
        if messageView == nil {
            messageView = MyMessage(text: text)
            messageView?.delegate = setMessageDelegate
        }
        messageView?.show(in: self.view)
    }
    
    func dismissMessage() {
        messageView?.hide()
    }
    
    //MARK: - 讀取視窗
    func showLoading() {
        if loadingView == nil {
            loadingView = MyLoading()
        }
        loadingView?.show(in: self.view)
    }
    
    func dismissLoading() {
        loadingView?.hide()
    }
    
    //MARK: - 自定義Print
    func MyPrint(_ items: Any..., separator: String = " ", terminator: String = "\n"){
        print("zhan: \(items)", separator: separator, terminator: terminator)
    }
    
    // MARK: - 鍵盤處理
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardHeight = keyboardFrame.height
        
        guard let firstResponder = findFirstResponder(in: view) else { return }
        
        let responderFrame = firstResponder.convert(firstResponder.bounds, to: self.view)
        let responderMaxY = responderFrame.maxY // 輸入框底部的 Y 座標
        let visibleHeight = self.view.frame.height - keyboardHeight // 鍵盤彈起後可見區域
        
        if responderMaxY > visibleHeight {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -keyboardHeight / 1.5
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
    
    private func findFirstResponder(in view: UIView) -> UIView? {
        if view.isFirstResponder {
            return view
        }
        for subview in view.subviews {
            if let responder = findFirstResponder(in: subview) {
                return responder
            }
        }
        return nil
    }
    
    // MARK: - 點擊空白區域隱藏鍵盤
    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
