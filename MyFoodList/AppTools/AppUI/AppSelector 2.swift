//
//  AppSelector.swift
//  transfer
//
//  Created by 紹郁 on 2024/10/29.
//

import UIKit

class AppSelector: UIView {

    private let newTextField = MyTextField()
    private let selectButton = MyImageButton(image: .unselectList)
    private let iconImage = MyImage()
    private let spacer = MySpacer()
    private let selectorView = MyStack()
    
    var fieldText: String? {
        get {
            newTextField.text
        }
        set {
            newTextField.text = newValue
        }
    }
    
    var isSelect: Bool = false {
        didSet {
            selectButton.setContentImage = isSelect ? .selectList : .unselectList
            newTextField.layer.borderColor = isSelect ? UIColor.oceanBlue.cgColor : UIColor.skyGray.cgColor
        }
    }
    
    var setIcon: UIImage? = nil {
        didSet {
            iconImage.image = setIcon
            newTextField.leftViewMode = .always
        }
    }
    
    var onTapAction: (() -> Void)?
    
    init(){
        super.init(frame: .zero)
        setupUI()
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: AppSelector) has not been implemented")
    }
    
    private func setupUI(){
        
        selectButton.showsMenuAsPrimaryAction = true
        
        // 設定 TextField
        newTextField.font = UIFont.callout
        newTextField.placeholder = ""
        newTextField.backgroundColor = .pureWhite
        newTextField.layer.borderColor = UIColor.skyGray.cgColor
        newTextField.layer.borderWidth = 2
        newTextField.layer.cornerRadius = 10
        newTextField.textAlignment = .left
        newTextField.isUserInteractionEnabled = false
        newTextField.leftViewMode = .never
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
