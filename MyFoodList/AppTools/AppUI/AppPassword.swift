//
//  AppPassword.swift
//  transfer
//
//  Created by 紹郁 on 2024/9/19.
//

import UIKit

class AppPassword: UIView {
    
    private(set) var newTextField = MyTextField()
    private let errorLabel = MyLabel()
    private let errorView = MyView()
    private let passwordButton = MyImageButton(image: .eyeClose)
    private let iconImage = MyImage(image: .password)
    private let editView = MyStack()
    
    var fieldText: String? {
        get {
            newTextField.text
        }
        set {
            newTextField.text = newValue
        }
    }
    
    var fieldFont: UIFont = .body {
        didSet {
            newTextField.font = fieldFont
        }
    }
        
    var isSelect: Bool = false {
        didSet {
            borderColor = isSelect ? UIColor.oceanBlue.cgColor : UIColor.skyGray.cgColor
            newTextField.layer.borderColor = borderColor
            shouldShowError = false
        }
    }
    
    private var borderColor: CGColor? = UIColor.skyGray.cgColor
    
    var setFieldBorderColor: CGColor? = UIColor.skyGray.cgColor {
        didSet {
            borderColor = setFieldBorderColor
            newTextField.layer.borderColor = borderColor
        }
    }
    
    var setCornerRadius: CGFloat = 0 {
        didSet {
            newTextField.layer.cornerRadius = setCornerRadius
        }
    }
    
    var setBorderWidth: CGFloat = 0 {
        didSet {
            newTextField.layer.borderWidth = setBorderWidth
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
    
    var showPassword: Bool = false {
        didSet {
            switch showPassword {
            case true:
                passwordButton.setImage(.eyeOpen, for: .normal)
            case false:
                passwordButton.setImage(.eyeClose, for: .normal)
            }
            newTextField.isSecureTextEntry = !showPassword
        }
    }
    
    var setKeyboardType: UIKeyboardType = .default {
        didSet {
            newTextField.keyboardType = setKeyboardType
        }
    }
    
    var setAutocapitalizationType: UITextAutocapitalizationType = .none {
        didSet {
            newTextField.autocapitalizationType = setAutocapitalizationType
        }
    }
    
    var showFieldIcon: Bool = false {
        didSet {
            newTextField.leftViewMode = showFieldIcon ? .always : .never
            newTextField.padding(left: 25)
        }
    }
    
    var setPlaceholder: String = "" {
        didSet {
            newTextField.placeholder = setPlaceholder
        }
    }
    
    func setDelegate(_ delegate: UITextFieldDelegate){
        newTextField.delegate = delegate
    }
    
    init(placeholder: String? = nil){
        super.init(frame: .zero)
        setupUI(placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(placeholder: String?){

        iconImage.tintColor = .black
        passwordButton.tintColor = .clear
        passwordButton.buttonAction = {
            self.showPassword.toggle()
        }
        
        // 設定 TextField
        newTextField.placeholder = placeholder
        newTextField.font = UIFont.callout
        newTextField.backgroundColor = .pureWhite
        newTextField.layer.borderColor = UIColor.skyGray.cgColor
        newTextField.layer.borderWidth = 2
        newTextField.layer.cornerRadius = 10
        newTextField.keyboardType = .alphabet
        newTextField.isSecureTextEntry = !showPassword
        newTextField.textAlignment = .left
        newTextField.leftView = iconImage
        newTextField.leftViewMode = .always
        newTextField.rightView = passwordButton
        newTextField.rightViewMode = .always
        newTextField.padding(left: 15)
        
        errorLabel.text = errorText
        errorLabel.textColor = .coralRed
        errorLabel.font = .subheadline
        errorLabel.textAlignment = .right
        errorLabel.isHidden = !shouldShowError
        errorLabel.backgroundColor = .clear
        errorLabel.padding()
        
        errorView.addSubview(errorLabel)
        errorLabel.paddingAnchor(equalTo: errorView)
        
        editView.addArrangedSubviews([newTextField, errorView])
        editView.backgroundColor = .clear
        editView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(editView)
        
        NSLayoutConstraint.activate([
            editView.topAnchor.constraint(equalTo: topAnchor),
            editView.bottomAnchor.constraint(equalTo: bottomAnchor),
            editView.leadingAnchor.constraint(equalTo: leadingAnchor),
            editView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            newTextField.heightAnchor.constraint(equalTo: editView.heightAnchor, multiplier: 0.7),
            newTextField.widthAnchor.constraint(equalTo: editView.widthAnchor),
            
            errorView.heightAnchor.constraint(equalTo: editView.heightAnchor, multiplier: 0.3),
            errorView.widthAnchor.constraint(equalTo: editView.widthAnchor),
        ])
    }
}
