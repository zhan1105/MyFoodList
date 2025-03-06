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
    private let errorLabel = MyLabel()
    private let errorView = MyView()
    private let selectorView = MyStack()
    
    var fieldText: String? {
        get {
            newTextField.text
        }
        set {
            newTextField.text = newValue
        }
    }
    
    var fieldPlaceholder: String? {
        get {
            newTextField.placeholder
        }
        set {
            newTextField.placeholder = newValue
        }
    }
    
    var fieldFont: UIFont? {
        get {
            newTextField.font
        }
        set {
            newTextField.font = newValue
        }
    }
    
    var isSelect: Bool = false {
        didSet {
            borderColor = isSelect ? select_BorderColor : unselect_BorderColor
            selectButton.setContentImage = isSelect ? .selectList : .unselectList
            newTextField.layer.borderColor = borderColor
            shouldShowError = false
        }
    }
    
    var setIcon: UIImage? = nil {
        didSet {
            iconImage.image = setIcon
            newTextField.leftViewMode = .always
        }
    }
    
    var onTapAction: (() -> Void)?
    
    private var borderColor: CGColor? = nil
    var select_BorderColor: CGColor? = UIColor.oceanBlue.cgColor
    var unselect_BorderColor: CGColor? = UIColor.skyGray.cgColor
    
    var setBorderColor: CGColor? {
        get {
            newTextField.layer.borderColor
        }
        set {
            unselect_BorderColor = newValue
            newTextField.layer.borderColor = unselect_BorderColor
        }
    }
    
    var setCornerRadius: CGFloat = 0 {
        didSet {
            newTextField.layer.cornerRadius = setCornerRadius
        }
    }
    
    var errorText: String? = nil {
        didSet {
            errorLabel.text = errorText
        }
    }
    
    var shouldShowError: Bool = false {
        didSet {
            newTextField.layer.borderColor = shouldShowError ? UIColor.coralRed.cgColor : borderColor
            errorLabel.isHidden = !shouldShowError
        }
    }
    
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
        newTextField.leftView = iconImage
        newTextField.leftViewMode = .never
        newTextField.rightView = selectButton
        newTextField.rightViewMode = .always
        newTextField.padding(left: 25)
        
        errorLabel.text = errorText
        errorLabel.textColor = .coralRed
        errorLabel.font = .subheadline
        errorLabel.textAlignment = .right
        errorLabel.isHidden = !shouldShowError
        errorLabel.backgroundColor = .clear
        
        errorView.addSubview(errorLabel)
        errorLabel.paddingAnchor(equalTo: errorView)
        
        selectorView.addArrangedSubviews([newTextField, errorView])
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
            
            errorView.heightAnchor.constraint(equalTo: selectorView.heightAnchor, multiplier: 0.3),
            errorView.widthAnchor.constraint(equalTo: selectorView.widthAnchor),
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
