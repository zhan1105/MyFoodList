//
//  SegmentedControlUI.swift
//  transfer
//
//  Created by 紹郁 on 2024/12/25.
//

import UIKit

class MyPackageControl: UIView {
    
    private var padding: UIEdgeInsets = .zero
    private var segmentedControl: UISegmentedControl!
    private let newPackageView = UIView()
    
    var onSegmentChanged: ((Int) -> Void)?
    
    var setFont: UIFont = UIFont.body {
        didSet {
            segmentedControl.setTitleTextAttributes([.font: setFont], for: .normal)
            segmentedControl.setTitleTextAttributes([.font: setFont], for: .selected)
        }
    }
    
    var setNormalColor: UIColor = .pureWhite {
        didSet {
            segmentedControl.setTitleTextAttributes([.foregroundColor: setNormalColor], for: .normal)
        }
    }
    
    var setSelectColor: UIColor = .oceanBlue {
        didSet {
            segmentedControl.setTitleTextAttributes([.foregroundColor: setSelectColor], for: .selected)
        }
    }
    
    func setSegmentedControlColor(tintColor: UIColor, backgroundColor: UIColor){
        segmentedControl.backgroundColor = backgroundColor
        segmentedControl.selectedSegmentTintColor = tintColor
    }
    
    init(_ item: [String]? = nil){
        super.init(frame: .zero)
        setupUI(item: item)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: SegmentedControlUI) has not been implemented")
    }
    
    private func setupUI(item: [String]?){
        // 初始化 segmentedControl 並設置預設項目
        segmentedControl = UISegmentedControl(items: item)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .clear
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        newPackageView.addSubview(segmentedControl)
        newPackageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(newPackageView)
        NSLayoutConstraint.activate([
            newPackageView.topAnchor.constraint(equalTo: topAnchor),
            newPackageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            newPackageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            newPackageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }
    
    // 事件處理方法
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        onSegmentChanged?(selectedIndex)  // 執行屬性中的回調
    }
    
    func viewPadding(to padding: CGFloat = 0,
                     top: CGFloat? = nil, bottom: CGFloat? = nil,
                     left: CGFloat? = nil, right: CGFloat? = nil){
        self.padding = UIEdgeInsets(
            top:    top     ?? padding,
            left:   left    ?? padding,
            bottom: bottom  ?? padding,
            right:  right   ?? padding
        )
        
        NSLayoutConstraint.deactivate(segmentedControl.constraints) // 清除舊約束
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: newPackageView.topAnchor, constant: self.padding.top),
            segmentedControl.bottomAnchor.constraint(equalTo: newPackageView.bottomAnchor, constant: -self.padding.bottom),
            segmentedControl.leadingAnchor.constraint(equalTo: newPackageView.leadingAnchor, constant: self.padding.left),
            segmentedControl.trailingAnchor.constraint(equalTo: newPackageView.trailingAnchor, constant: -self.padding.right)
        ])
    }
}
