//
//  MyLinkLabel.swift
//  transfer
//
//  Created by 紹郁 on 2024/9/11.
//

import UIKit

class MyLinkLabel: UILabel {
    
    // 超連結URL
    private var linkURL: URL?
    
    var setText: String = "" {
        didSet {
            self.attributedText = createAttributedText(text: setText)
        }
    }
    
    var setUrl: String = "" {
        didSet {
            linkURL = URL(string: setUrl)
        }
    }
    
    // 初始化方法
    init(text: String = "", linkURL: URL? = nil) {
        self.linkURL = linkURL
        super.init(frame: .zero)
        setupUI(text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(text: String) {
        self.attributedText = createAttributedText(text: text)
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        self.addGestureRecognizer(tapGesture)
        self.numberOfLines = 2
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private var textPadding: UIEdgeInsets = .zero
    
    // 設定 padding
    func padding(to padding: CGFloat = 5,
                 top: CGFloat? = nil, bottom: CGFloat? = nil,
                 left: CGFloat? = nil, right: CGFloat? = nil) {
        
        let topPadding      = top ?? padding
        let bottomPadding   = bottom ?? padding
        let leftPadding     = left ?? padding
        let rightPadding    = right ?? padding
        
        textPadding = UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding)
        
        setNeedsDisplay()
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textPadding))
    }
    
    // 創建帶有顏色和底線的富文本
    private func createAttributedText(text: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.oceanBlue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    // 處理點擊事件
    @objc private func labelTapped() {
        guard let url = linkURL else { return }
        UIApplication.shared.open(url)
    }
}
