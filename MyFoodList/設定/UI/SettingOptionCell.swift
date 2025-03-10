//
//  SettingOptionUI.swift
//  MyFoodList
//
//  Created by 紹郁 on 2025/3/7.
//

import UIKit

class SettingOptionCell: UITableViewCell {

    private let optionLabel = MyLabel()
    private let optionSwitch = MyPackageSwitch()
    private let spacer = MySpacer()

    var setOptionText: String = "" {
        didSet{
            optionLabel.text = setOptionText
        }
    }
    
    var isShowSwitch: Bool = false {
        didSet{
            optionSwitch.isHidden = !isShowSwitch
            spacer.isHidden = isShowSwitch
        }
    }
    
    var setSwitchOn: Bool = false {
        didSet {
            optionSwitch.setOn = setSwitchOn
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        let selectedView = UIView()
        selectedView.backgroundColor = .clear
        self.selectedBackgroundView = selectedView
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: NotificationCell) has not been implemented")
    }
    
    private func setupUI(){
        
        let width = UIScreen.main.bounds.width
        
        optionLabel.font = .boldBody
        optionLabel.textAlignment = .left
        optionLabel.padding(left: width * 0.05)
        
        optionSwitch.setOn = false
        optionSwitch.setBackgroundColor = .oceanBlue
        
        let subScreen = MyStack(arrangedSubviews: [optionLabel, optionSwitch, spacer])
        subScreen.axis = .horizontal
        subScreen.backgroundColor = .pureWhite
        subScreen.layer.cornerRadius = 20
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor, constant: width * 0.0125),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -width * 0.0125),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor, constant: width * 0.05),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -width * 0.05),
            
            optionLabel.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.75),
            optionSwitch.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.25),
            spacer.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.25),
        ])
    }
}
