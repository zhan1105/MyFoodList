//
//  MyLabel.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/29.
//

import UIKit

class MyLabel: UILabel {
    
    init(text: String = "Label") {
        super.init(frame: .zero)
        setupUI(text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(text: String) {
        self.text = text
        self.textColor = .charcoalBlack
        self.textAlignment = .center
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private var textPadding: UIEdgeInsets = .zero
    
    // 添加 padding 方法
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
    
    private var cornerRadii: (topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) = (0, 0, 0, 0)
    
    func setCornerRadius(to radius: CGFloat = 0,
                          topLeft: CGFloat? = nil,    topRight: CGFloat? = nil,
                          bottomLeft: CGFloat? = nil, bottomRight: CGFloat? = nil) {
        
        let topLeftRadius       = topLeft ?? radius
        let topRightRadius      = topRight ?? radius
        let bottomLeftRadius    = bottomLeft ?? radius
        let bottomRightRadius   = bottomRight ?? radius
        
        cornerRadii = (topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius)
        setNeedsLayout()
    }
    
    override func drawText(in rect: CGRect) {
        
        let path = UIBezierPath()
        
        // 設定路徑，根據角的圓角半徑來繪製
        path.move(to: CGPoint(x: rect.minX + cornerRadii.topLeft, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadii.topRight, y: rect.minY))
        path.addArc(withCenter: CGPoint(x: rect.maxX - cornerRadii.topRight, y: rect.minY + cornerRadii.topRight), radius: cornerRadii.topRight, startAngle: CGFloat(3 * Double.pi / 2), endAngle: 0, clockwise: true)
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadii.bottomRight))
        path.addArc(withCenter: CGPoint(x: rect.maxX - cornerRadii.bottomRight, y: rect.maxY - cornerRadii.bottomRight), radius: cornerRadii.bottomRight, startAngle: 0, endAngle: CGFloat(Double.pi / 2), clockwise: true)
        
        path.addLine(to: CGPoint(x: rect.minX + cornerRadii.bottomLeft, y: rect.maxY))
        path.addArc(withCenter: CGPoint(x: rect.minX + cornerRadii.bottomLeft, y: rect.maxY - cornerRadii.bottomLeft), radius: cornerRadii.bottomLeft, startAngle: CGFloat(Double.pi / 2), endAngle: CGFloat(Double.pi), clockwise: true)
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadii.topLeft))
        path.addArc(withCenter: CGPoint(x: rect.minX + cornerRadii.topLeft, y: rect.minY + cornerRadii.topLeft), radius: cornerRadii.topLeft, startAngle: CGFloat(Double.pi), endAngle: CGFloat(3 * Double.pi / 2), clockwise: true)
        
        path.close()
        
        // 創建遮罩層
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
        
        super.drawText(in: rect.inset(by: textPadding))
    }
}
