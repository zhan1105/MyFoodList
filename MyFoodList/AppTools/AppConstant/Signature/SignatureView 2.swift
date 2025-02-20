//
//  SignatureView.swift
//  CAShapeLayerTest
//
//  Created by 紹郁 on 2024/8/13.
//

import UIKit

class SignatureView: UIView {
    
    private var lines: [[CGPoint]] = []
    
    var onDrawnStateChanged: ((Bool) -> Void)?
    
    private(set) var hasDrawn: Bool = false {
        didSet {
            onDrawnStateChanged?(hasDrawn)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
        hasDrawn = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self), var lastLine = lines.popLast() else {
            return
        }
        lastLine.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(2)
        context.setLineCap(.round)
        
        lines.forEach { line in
            guard let firstPoint = line.first else { return }
            context.beginPath()
            context.move(to: firstPoint)
            line.dropFirst().forEach { point in
                context.addLine(to: point)
            }
            context.strokePath()
        }
    }
    
    func clear() {
        lines.removeAll()
        hasDrawn = false
        setNeedsDisplay()
    }
    
    func asImage() -> UIImage? {
        // 使用透明背景的圖像上下文
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // 設置透明背景
        context.clear(self.bounds)
        
        // 開始繪製簽名線條
        context.setStrokeColor(UIColor.black.cgColor) // 設置線條顏色
        context.setLineWidth(2)                       // 設置線條寬度
        context.setLineCap(.round)                    // 設置線條端點樣式
        
        lines.forEach { line in
            guard let firstPoint = line.first else { return }
            context.beginPath()
            context.move(to: firstPoint)
            line.dropFirst().forEach { point in
                context.addLine(to: point)
            }
            context.strokePath()
        }
        
        // 從圖像上下文獲取 UIImage
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

