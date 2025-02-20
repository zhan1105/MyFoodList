//
//  MyMessage.swift
//  transfer
//
//  Created by 紹郁 on 2024/9/23.
//

import UIKit

class MyMessage: UIView {
    
    private var messageLabel = MyLabel()
    private var actionButton = MyPackageButton()
    
    weak var delegate: MyMessageDelegate?

    init(text: String = "") {
        super.init(frame: .zero)
        setupUI(text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(text: String) {
        
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        
        // 設定訊息文字視圖
        messageLabel.text = text
        messageLabel.font = .title3
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        // 設定按鈕
        actionButton = MyPackageButton(text: .localizedString(for: .shared(.Confirm)))
        actionButton.viewPadding(to: 0, bottom: 20)
        actionButton.buttonAction = { [weak self] in
            guard let self = self else { return }
            self.delegate?.setButtonAction()
            self.hide()
        }
        
        // 使用堆疊視圖管理佈局
        let subScreen = MyStack(arrangedSubviews: [messageLabel, actionButton])
        subScreen.axis = .vertical
        subScreen.alignment = .center
        subScreen.layer.cornerRadius = 10
        subScreen.backgroundColor = .white
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black.withAlphaComponent(0.6)
        backgroundView.addSubview(subScreen)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
                
        self.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            subScreen.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            subScreen.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            subScreen.widthAnchor.constraint(equalToConstant: width * 0.9),
            
            messageLabel.widthAnchor.constraint(equalToConstant: width * 0.8),
            
            actionButton.widthAnchor.constraint(equalToConstant: width * 0.8),
            actionButton.heightAnchor.constraint(equalToConstant: height * 0.085),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let textHeight = messageLabel.sizeThatFits(
            CGSize(width: UIScreen.main.bounds.width * 0.8,
                   height: CGFloat.greatestFiniteMagnitude)).height
        
        let buttonHeight: CGFloat = UIScreen.main.bounds.height * 0.15
        
        let totalHeight = textHeight + buttonHeight
        
        let minHeight: CGFloat = UIScreen.main.bounds.height * 0.25
        let finalHeight = max(totalHeight, minHeight)
        
        if let subScreen = subviews.first?.subviews.first as? UIStackView {
            subScreen.heightAnchor.constraint(equalToConstant: finalHeight).isActive = true
        }
    }
    
    func show(in view: UIView) {
        self.frame = view.bounds
        self.alpha = 0
        view.addSubview(self)
        
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
