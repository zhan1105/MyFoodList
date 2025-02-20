//
//  MyPackageSwitch.swift
//  transfer
//
//  Created by 紹郁 on 2024/10/24.
//

import UIKit

class MyPackageSwitch: UIView {

    private var newPackageView = UIView()
    
    var newSwitch = UISwitch()
    var onTapAction: (() -> Void)?

    var setOn: Bool = false {
        didSet {
            newSwitch.setOn(setOn, animated: true)
        }
    }
    
    var setBackgroundColor: UIColor = .blue {
        didSet {
            newSwitch.onTintColor = setBackgroundColor
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
        setupTapGesture() 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        newSwitch.isOn = false
        newSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        newSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        newPackageView.addSubview(newSwitch)
        newPackageView.backgroundColor = .clear
        newPackageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(newPackageView)
        NSLayoutConstraint.activate([
            newPackageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            newPackageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            newPackageView.topAnchor.constraint(equalTo: topAnchor),
            newPackageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            newSwitch.centerYAnchor.constraint(equalTo: newPackageView.centerYAnchor), 
            newSwitch.centerXAnchor.constraint(equalTo: newPackageView.centerXAnchor),
        ])
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    
    @objc private func handleTap() {
        newSwitch.setOn(!newSwitch.isOn, animated: true)
        onTapAction?()
    }

    @objc private func switchValueChanged(_ sender: UISwitch) {
        onTapAction?()
    }
}
