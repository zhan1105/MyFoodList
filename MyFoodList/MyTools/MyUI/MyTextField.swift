//
//  MyTextField.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/29.
//

import UIKit

class MyTextField: UITextField {
    
    private var topPadding: CGFloat = 0
    private var bottomPadding: CGFloat = 0
    private var leftPadding: CGFloat = 0
    private var rightPadding: CGFloat = 0
    
    private var leftWidth: CGFloat {
        return leftView?.frame.width ?? 0
    }
    private var rightWidth: CGFloat {
        return rightView?.frame.width ?? 0
    }

    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 設置 UI
    private func setupUI() {
        self.text = ""
        self.textColor = .charcoalBlack
        self.placeholder = "TextField"
        self.borderStyle = .none
        self.layer.cornerRadius = 10
        self.font = .callout
        self.textAlignment = .center
        self.backgroundColor = .white
        self.padding()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private var textPadding: UIEdgeInsets = .zero
    
    func padding(to padding: CGFloat = 10,
                 top: CGFloat? = nil, bottom: CGFloat? = nil,
                 left: CGFloat? = nil, right: CGFloat? = nil) {
        
        topPadding = top ?? padding
        bottomPadding = bottom ?? padding
        leftPadding = left ?? padding
        rightPadding = right ?? padding
        
        layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePadding()
    }
    
    // 更新內邊距
    private func updatePadding() {
        textPadding = UIEdgeInsets(top: topPadding, left: leftWidth + leftPadding, bottom: bottomPadding, right: rightWidth + rightPadding)
    }
    
    // 控制非編輯狀態下的文字顯示範圍
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    // 控制編輯狀態下的文字顯示範圍
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    // 控制佔位符的顯示範圍
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    // 控制 rightView 的顯示範圍
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.width - rightWidth - 10, y: 0, width: rightWidth, height: bounds.height)
    }
    
    // 控制 leftView 的顯示範圍
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 10, y: 0, width: leftWidth, height: bounds.height)
    }
}
