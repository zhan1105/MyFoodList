//
//  AppPassword.swift
//  transfer
//
//  Created by 紹郁 on 2024/9/19.
//

import UIKit

class LanguageSelector: UIView {
    
    private let nationalItem = NationalItem().option
    
    private let newTextField = MyTextField()
    private let selectButton = MyImageButton(image: .unselectList)
    private let iconImage = MyImage()
    private let spacer = MySpacer()
    private let selectorView = MyStack()
    
    var isSelect: Bool = false {
        didSet {
            selectButton.setContentImage = isSelect ? .selectList : .unselectList
            newTextField.layer.borderColor = isSelect ? UIColor.oceanBlue.cgColor : UIColor.skyGray.cgColor
        }
    }
    
    var setLanguage: SwitchLanguage = LanguageManager.shared.currentLanguage {
        didSet {
            if let languageItem = nationalItem.first(where: { $0.language == setLanguage }) {
                newTextField.text = languageItem.name
                iconImage.image = languageItem.image
            }
        }
    }
    
    var onTapAction: (() -> Void)?
    
    init(){
        super.init(frame: .zero)
        setupUI()
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        selectButton.showsMenuAsPrimaryAction = true
        
        // 設定 TextField
        newTextField.font = .title3
        newTextField.backgroundColor = .pureWhite
        newTextField.layer.borderColor = UIColor.skyGray.cgColor
        newTextField.layer.borderWidth = 2
        newTextField.layer.cornerRadius = 10
        newTextField.textAlignment = .left
        newTextField.isUserInteractionEnabled = false
        newTextField.leftView = iconImage
        newTextField.leftViewMode = .always
        newTextField.rightView = selectButton
        newTextField.rightViewMode = .always
        newTextField.padding(left: 25)
        
        selectorView.addArrangedSubviews([newTextField, spacer])
        selectorView.backgroundColor = .clear
        selectorView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(selectorView)
        
        NSLayoutConstraint.activate([
            selectorView.topAnchor.constraint(equalTo: topAnchor),
            selectorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            selectorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            newTextField.heightAnchor.constraint(equalTo: selectorView.heightAnchor, multiplier: 0.7),
            newTextField.widthAnchor.constraint(equalTo: selectorView.widthAnchor),
            
            spacer.heightAnchor.constraint(equalTo: selectorView.heightAnchor, multiplier: 0.3),
            spacer.widthAnchor.constraint(equalTo: selectorView.widthAnchor),
        ])
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    
    @objc private func handleTap() {
        isSelect = true
        onTapAction?()
    }
}
