//
//  MyDivider.swift
//  transfer
//
//  Created by 紹郁 on 2024/10/22.
//

import UIKit

enum DividerType {
    case Horizontal
    case Vertical
}

class MyDivider: UIView {
    
    private lazy var dividerSpacer: MySpacer = {
        let spacer = MySpacer()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        return spacer
    }()
    
    private lazy var dividerView: MyView = {
        let view = MyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var setDivider: DividerType = .Vertical {
        didSet {
            resetDivider(setDivider)
        }
    }
    
    init(_ dividerColor: UIColor = .softGray) {
        super.init(frame: .zero)
        setupUI(dividerColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(_ dividerColor: UIColor) {
        dividerSpacer.backgroundColor = dividerColor
        dividerView.addSubview(dividerSpacer)
        addSubview(dividerView)

        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: topAnchor),
            dividerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dividerSpacer.centerXAnchor.constraint(equalTo: dividerView.centerXAnchor),
            dividerSpacer.centerYAnchor.constraint(equalTo: dividerView.centerYAnchor)
        ])
        
        resetDivider(setDivider)
    }
    
    private func resetDivider(_ type: DividerType) {
        // 取消當前的寬度和高度約束
        dividerSpacer.constraints.forEach { constraint in
            if constraint.firstAttribute == .width || constraint.firstAttribute == .height {
                constraint.isActive = false
            }
        }
        
        switch type {
        case .Horizontal:
            NSLayoutConstraint.activate([
                dividerSpacer.widthAnchor.constraint(equalTo: dividerView.widthAnchor, multiplier: 0.9),
                dividerSpacer.heightAnchor.constraint(equalToConstant: 1)
            ])
        case .Vertical:
            NSLayoutConstraint.activate([
                dividerSpacer.widthAnchor.constraint(equalToConstant: 1),
                dividerSpacer.heightAnchor.constraint(equalTo: dividerView.heightAnchor, multiplier: 0.9)
            ])
        }
    }
}
